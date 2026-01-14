# Services HTTPRoutes

This chart deploys HTTPRoute resources to expose services via the Gateway API.

Update value.<ENV>.yaml files to configure which services to expose following this format:

```yaml
httpRoutes:
  …
  new-route-name:
    namespace: development
    hostname: "service-url.domain.tld"
    backend:
      name: "service-name"
      port: 80
```

**route-name**: Name of the HTTPRoute resource.  
**namespace**: (optional) Namespace where the service is deployed. Left empty, defaults to "development".  
**hostname**: Hostname to expose the service on. The certificate for this hostname must be added to the Gateway's Certificate Map using terraform `certificates` module.
**backend.name**: Name of the service to expose.  
**backend.port**: Port of the service to expose.

```shell
helm upgrade --install services-httproutes . \
  -f values.development.yaml \
  --wait
```
