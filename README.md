# ducknet-ops

## Bootstrapping

```bash
kubectl create namespace flux-system --dry-run=client -o yaml | kubectl apply -f -
cat <sops-key.txt> | kubectl --namespace flux-system create secret generic sops-age --from-file=age.agekey=/dev/stdin

helmfile --file "./bootstrap/helmfile.yaml" apply --hide-notes --skip-diff-on-install --suppress-diff --suppress-secrets
```
