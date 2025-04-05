# seabird-k8s

## Bootstrap Procedure

```
# Generate talos configs
cd talos && talhelper genconfig

# Apply all talos configs to hosts
talosctl apply-config --insecure -n 192.168.40.10 --file seabird-kupo.yaml
talosctl apply-config --insecure -n 192.168.40.11 --file seabird-stiltzkin.yaml
talosctl apply-config --insecure -n 192.168.40.12 --file seabird-moguo.yaml
talosctl apply-config --insecure -n 192.168.40.13 --file seabird-monty.yaml
talosctl apply-config --insecure -n 192.168.40.14 --file seabird-artemicion.yaml

# TODO: bootstrap flux secrets

# Bootstrap flux
flux bootstrap git \
  --url=ssh://git@github.com/seabird-chat/seabird-k8s
  --private-key-file=$HOME/seabird-k8s \
  --path=k8s/flux \
  --cluster-domain=infra.seabird.chat
```
