# NGINX-controller and Gateway API Comparison

Terrraform and Kubernetes resources to deploy a GKE cluster with both Gateway API and a NGINX Ingress Controller using cert-manager and a small app to compare ingress methods.

## Usage

```shell
# Authenticate with Google Cloud
gcloud auth application-default login

# Initialize Terraform
terraform init

# Apply the Terraform configuration
terraform apply
```

Use the output to create DNS records:

- A Records pointing to the Gateway and NGINX Ingress controller IP addresses.
- CNAME records for certificate validation (Used by Google Certificate Manager)

## Terraform Docs

Generate terraform documentation:

```shell
terraform-docs markdown --output-file README.md --output-mode inject .
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | terraform-iaac/cert-manager/kubernetes | 3.1.1 |
| <a name="module_nginx-controller"></a> [nginx-controller](#module\_nginx-controller) | terraform-iaac/nginx-controller/helm | 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_certificate_manager_certificate.certificate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate) | resource |
| [google_certificate_manager_certificate_map.gateway_certificate_map](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map) | resource |
| [google_certificate_manager_certificate_map_entry.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map_entry) | resource |
| [google_certificate_manager_dns_authorization.dns_authorizations](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_dns_authorization) | resource |
| [google_compute_address.gateway_load_balancer_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_address.nginx_load_balancer_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_container_cluster.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where resources will be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region where resources will be created | `string` | `"europe-west1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_dns_authorizations"></a> [certificate\_dns\_authorizations](#output\_certificate\_dns\_authorizations) | The DNS authorizations for the certificate to be added to DNS records from google\_certificate\_manager\_dns\_authorization.instance and google\_certificate\_manager\_dns\_authorizationinstance2's dns\_resource\_record attribute |
| <a name="output_gateway_external_ip"></a> [gateway\_external\_ip](#output\_gateway\_external\_ip) | The external IP address of the Gateway |
| <a name="output_nginx_external_ip"></a> [nginx\_external\_ip](#output\_nginx\_external\_ip) | The external IP address of the NGINX Ingress controller |
<!-- END_TF_DOCS -->