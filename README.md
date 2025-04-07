# seabird-k8s

## Bootstrap Procedure

The first step is to generate the talos configs and apply them to all our nodes.

```
# Generate talos configs
cd talos && talhelper genconfig

# Apply all talos configs to hosts
talosctl apply-config --insecure -n 192.168.40.10 --file seabird-kupo.yaml
talosctl apply-config --insecure -n 192.168.40.11 --file seabird-stiltzkin.yaml
talosctl apply-config --insecure -n 192.168.40.12 --file seabird-moguo.yaml
talosctl apply-config --insecure -n 192.168.40.13 --file seabird-monty.yaml
talosctl apply-config --insecure -n 192.168.40.14 --file seabird-artemicion.yaml
```

Now that we have some nodes up and running, we need to bootstrap the cluster.

```
talosctl bootstrap --talosconfig ./talos/clusterconfig/talosconfig -n 192.168.40.10
```

Finally, we need to bootstrap flux. This involves a few manual calls to `kubectl
apply` to set up secrets, but otherwise should be fairly painless.

```
# Bootstrap flux-system namespace and CRDs
kubectl apply --kustomize=./k8s/base/flux-system

# Set up the required secrets to bootstrap the cluster - this requires the
# relevant age key to be properly set up.
sops -d ./k8s/base/bootstrap/flux-secret.sops.yaml | kubectl apply -f -
sops -d ./k8s/base/bootstrap/flux-sops-age-secret.sops.yaml | kubectl apply -f -
```

Once the secrets are configured, we can kick off a bootstrap of the whole
cluster.

```
kubectl apply --kustomize=./k8s/base/cluster
```
