# Services HTTPRoutes

This chart deploys HTTPRoute resources to expose services via the Gateway API.

Update value.<ENV>.yaml files to configure which services to expose following this format:

```yaml
httpRoutes:
  ...
  new-route-name:
    namespace: "development"
    hostname: "service-url.domain.tld"
    path: "/"
    backend:
      name: "service-name"
      port: 80
      requestPath: "/healthz"
```

| Name | Description | Default |
|---|---|---|
| `route-name` | Name of the HTTPRoute resource. A service and health check will also be created with this name. | N/A |
| `namespace` | (optional) Namespace where the service is deployed. | `"default"` |
| `hostname` | Hostname to expose the service on. The certificate for this hostname must be added to the Gateway. | N/A |
| `path` | (optional) The path to match for routing traffic. | `"/"` |
| `backend.name` | (optional) Name of the service to expose. If not provided, a new `ClusterIP` service is created and used. | `[route-name]-clusterip`|
| `backend.port` | Port of the service to expose. | N/A |
| `backend.requestPath`| (optional) The path to use for health checks. | `"/"` |

## Backend Policy

It is possible to configure a `GCPBackendPolicy` for each route.

```yaml
httpRoutes:
  ...
  new-route-name:
    ...
    backendPolicy:
      drainingTimeoutSec: 60
      sessionAffinityType: "GENERATED_COOKIE"
      timeoutSec: 40
      enableIAP: true
      iapSecretName: "my-iap-secret"
      IAP_CLIENT_ID: "my-iap-client-id"
```

| Name | Description | Default |
|---|---|---|
| `backendPolicy` | (optional) If defined, a `GCPBackendPolicy` resource is created. | N/A |
| `backendPolicy.drainingTimeoutSec` | (optional) Connection draining timeout in seconds. | `60` |
| `backendPolicy.sessionAffinityType` | (optional) Session affinity type. Can be `CLIENT_IP` or `GENERATED_COOKIE`. | `CLIENT_IP` |
| `backendPolicy.timeoutSec` | (optional) Backend timeout in seconds. | `40` |
| `backendPolicy.enableIAP` | (optional) Enable IAP (Identity-Aware Proxy). | `false` |
| `backendPolicy.iapSecretName` | (optional) Name of the secret containing the IAP OAuth2 client secret. | `[route-name]-iap` |
| `backendPolicy.IAP_CLIENT_ID`| (required if IAP is enabled) The IAP client ID. | N/A |

## Install the Chart

```shell
helm upgrade --install services-httproutes . \
  -f values.development.yaml \
  --wait
```
