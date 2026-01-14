# Gateway API

This Helm chart deploys a Gateway API Gateway resource configured to use a Google Cloud external HTTP(S) Load Balancer with a static IP address and a certificate map for TLS termination.

```shell
helm upgrade --install gateway-api . \
  -n gateway-system \
  -f values.production.yaml \
  --create-namespace \
  --wait
```
