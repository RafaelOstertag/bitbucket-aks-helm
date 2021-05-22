Docker Images for Azure with kubectl and helm installed. Can be used as Bitbucket Pipes.

All images have `az` installed in `/usr/local/bin`. In addition `aks-kubectl` has `kubectl`, and `aks-helm` has `helm`
installed at the same spot.

Use `aks-helm-deploy-from-tag` to deploy from tags. It will look it the commit it runs on is a tag that starts with `v` and
will set the image version to whatever follows `v`. E.g. if the tag is named `v1.0.0` it will set the image version
to `1.0.0`. Apart from that, it's identical to `aks-helm`.
