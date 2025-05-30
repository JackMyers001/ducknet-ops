# Bootstrapping

## Install Cilium

Taken from the [Talos Deploying Cilium CNI guide](https://www.talos.dev/v1.9/kubernetes-guides/network/deploying-cilium/#method-1-helm-install), We deploy without `kube-proxy`.

```bash
helm install \
    cilium \
    cilium/cilium \
    --version 1.17.2 \
    --namespace kube-system \
    --values kubernetes/apps/kube-system/cilium/app/helm-values.yaml
```

## Install Prometheus Operator CRDs

- `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
- Check the latest version [here](https://github.com/prometheus-community/helm-charts/)

```bash
helm install \
    prometheus-operator-crds \
    prometheus-community/prometheus-operator-crds \
    --version 20.0.0 \
    --namespace observability \
    --create-namespace
```

## Install Flux

- `kubectl apply --server-side --kustomize kubernetes/bootstrap`
- `kubectl create -n flux-system secret generic github-pat --from-literal=username=git --from-literal=password=<PAT>`
- `cat <sops-key.txt> | kubectl --namespace flux-system create secret generic sops-age --from-file=age.agekey=/dev/stdin`
- `kubectl apply --server-side --kustomize kubernetes/flux/config`

## Jack Troll

```bash
k apply -f ./kubernetes/apps/rook-ceph/namespace.yaml
```

```bash
helm install \
    rook-ceph \
    rook-release/rook-ceph \
    --version v1.16.6 \
    --namespace rook-ceph \
    --values kubernetes/apps/rook-ceph/app/values.yaml
```

```bash
cd ~/git-src/external-snapshotter
kubectl kustomize client/config/crd | kubectl create -f -
```

```bash
helm install \
    rook-ceph-cluster \
    rook-release/rook-ceph-cluster \
    --version v1.16.6 \
    --namespace rook-ceph \
    --values kubernetes/apps/rook-ceph/cluster/values.yaml
```

```bash
helm install \
    kube-prometheus-stack \
    prometheus-community/kube-prometheus-stack \
    --version 70.4.1 \
    --namespace observability \
    --values kubernetes/apps/observability/kube-prometheus-stack/app/values.yaml
```

```bash
helm install \
    openebs  \
    openebs/openebs \
    --version 4.2.0 \
    --namespace openebs \
    --values openebs-values.yaml
```
