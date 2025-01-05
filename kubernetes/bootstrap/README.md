# Bootstrapping

## Install Cilium

Taken from the [Talos Deploying Cilium CNI guide](https://www.talos.dev/v1.9/kubernetes-guides/network/deploying-cilium/#method-1-helm-install), We deploy without `kube-proxy`.

```bash
helm install \
    cilium \
    cilium/cilium \
    --version 1.16.5 \
    --namespace kube-system \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445
```

## Install Flux

- `kubectl apply --server-side --kustomize kubernetes/bootstrap`
- `kubectl create -n flux-system secret generic github-pat --from-literal=username=git --from-literal=password=<PAT>`
- `kubectl apply --server-side --kustomize kubernetes/flux/config`
