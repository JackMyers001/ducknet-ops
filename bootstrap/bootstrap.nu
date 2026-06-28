#!/usr/bin/env nu

use std/log

def get-resource-path [namespace: string, name: string, resource: string] {
    [
        ".."
        "kubernetes"
        "apps"
        $namespace
        $name
        "app"
        $resource
    ] | path join
}

def get-flux-values [namespace: string, name: string] {
    log debug $"Getting Flux values for ($namespace)/($name)"

    let oci = open (get-resource-path $namespace $name "ocirepository.yaml")
    let hr = open (get-resource-path $namespace $name "helmrelease.yaml")

    {
        chart: $oci.spec.url
        version: ($oci.spec.ref.tag | into string)
        values: ($hr.spec.values? | default {} | to yaml)
    }
}

# Replaces ${KEY} occurrences in the piped-in string
def substitute-vars [vars: record]: string -> string {
    let input = $in

    $vars | transpose key value | reduce --fold $input {|it, acc|
        $acc | str replace --all ("${" + $it.key + "}") $it.value
    }
}

def bootstrap-helm-release [namespace: string, name: string, vars: record = {}] {
    log info $"Bootstrapping Helm release for ($namespace)/($name)"

    let release = get-flux-values $namespace $name

    $release.values
    | substitute-vars $vars
    | ^helm upgrade --install $name $release.chart --namespace $namespace --create-namespace --version $release.version --values /dev/stdin --wait --wait-for-jobs
}

def apply-crds [namespace: string, name: string, vars: record = {}] {
    log info $"Bootstrapping CRDs from Helm release ($namespace)/($name)"

    let release = get-flux-values $namespace $name

    $release.values
    | substitute-vars $vars
    | ^helm template $name $release.chart --version $release.version --values /dev/stdin --include-crds
    | from yaml
    | where kind? == "CustomResourceDefinition"
    | each { to yaml }
    | str join "---\n"
    | kubectl apply --server-side --force-conflicts -f -
}

def apply-kubernetes-resource [
    namespace: string
    name: string
    resource: string
    vars: record = {}
] {
    log info $"Applying Kubernetes resource for ($namespace)/($name) - ($resource)"

    get-resource-path $namespace $name $resource
    | open --raw
    | substitute-vars $vars
    | ^kubectl apply --namespace $namespace --server-side --force-conflicts --filename -
}

# Get the BW Secrets Manager API token from the BW password vault
let bws_token = (^vals get ref+bw://4a42f02a-3571-4cec-b1b5-b45f0100cbe3)

# Get the Kubernetes global secrets from BW Secrets Manager
let vars = (
    BWS_ACCESS_TOKEN=$bws_token ^bws secret get 3a4d5795-189c-46ff-9f03-b46200f7f8a3
    | from json
    | get "value"
    | from json
)

# Log into GHCR reo for Helm (fixes weird 403 issues; see https://jon.sprig.gs/blog/post/3141)
^gh auth token | ^helm registry login ghcr.io --username unused --password-stdin

kustomize build kustomize/apps | vals eval -f - | kubectl apply --server-side --force-conflicts -f -

apply-crds observability grafana-operator
apply-crds observability kube-prometheus-stack

# Cilium
bootstrap-helm-release kube-system cilium $vars
apply-kubernetes-resource kube-system cilium "networking.yaml" $vars

# cert-manager
bootstrap-helm-release cert-manager cert-manager

# External Secrets Operator
apply-kubernetes-resource external-secrets bitwarden-sdk-server issuer.yaml
apply-kubernetes-resource external-secrets bitwarden-sdk-server certificate.yaml

bootstrap-helm-release external-secrets external-secrets
bootstrap-helm-release external-secrets bitwarden-sdk-server

(apply-kubernetes-resource
    external-secrets
    bitwarden-sdk-server
    clustersecretstore.yaml
)

# Flux
bootstrap-helm-release flux-system flux-operator
bootstrap-helm-release flux-system flux-instance
