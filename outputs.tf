output "certificate_dns_authorizations" {
  description = "The DNS authorizations for the certificate to be added to DNS records from google_certificate_manager_dns_authorization.instance and google_certificate_manager_dns_authorizationinstance2's dns_resource_record attribute"
  value       = flatten([for d in values(google_certificate_manager_dns_authorization.dns_authorizations) : d.dns_resource_record])
}

output "gateway_external_ip" {
  description = "The external IP address of the Gateway"
  value       = google_compute_address.gateway_load_balancer_ip.address
}

output "nginx_external_ip" {
  description = "The external IP address of the NGINX Ingress controller"
  value       = google_compute_address.nginx_load_balancer_ip.address
}
