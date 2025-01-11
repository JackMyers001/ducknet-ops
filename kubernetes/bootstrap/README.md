# Bootstrapping

## Install Cilium

Taken from the [Talos Deploying Cilium CNI guide](https://www.talos.dev/v1.9/kubernetes-guides/network/deploying-cilium/#method-1-helm-install), We deploy without `kube-proxy`.

```bash
helm install \
    cilium \
    cilium/cilium \
    --version 1.16.5 \
    --namespace kube-system \
    --values kubernetes/apps/kube-system/cilium/app/helm-values.yam
```

## Install Prometheus Operator CRDs

- `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
- Check the latest version [here](https://github.com/prometheus-community/helm-charts/)

```bash
helm install \
    prometheus-operator-crds \
    prometheus-community/prometheus-operator-crds \
    --version 17.0.2 \
    --namespace observability \
    --create-namespace
```

## Install Flux

- `kubectl apply --server-side --kustomize kubernetes/bootstrap`
- `kubectl create -n flux-system secret generic github-pat --from-literal=username=git --from-literal=password=<PAT>`
- `cat <sops-key.txt> | kubectl --namespace flux-system create secret generic sops-age --from-file=age.agekey=/dev/stdin`
- `kubectl apply --server-side --kustomize kubernetes/flux/config`
