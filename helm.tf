# DEFAULT VERSIONS OF MODULES CERT-MANAGER AND NGINX-CONTROLLER ARE NOT COMPATIBLE
# EITHER FORCE NGINX CHART VERSION >= 4.13.2 AND CERT-MANAGER CHART VERSION >= 1.19.0
# OR DISABLE THE ACME HTTP01 INGRESS PATHTYPE EXACT FEATURE GATE
# https://cert-manager.io/docs/releases/release-notes/release-notes-1.18/#acme-http01-challenge-paths-now-use-pathtype-exact-in-ingress-routes


module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"
  version = "3.0.0"

  chart_version = "4.13.3" # Release date: 30 Sep, 2025

  ip_address = google_compute_address.nginx_load_balancer_ip.address
}

module "cert_manager" {
  source  = "terraform-iaac/cert-manager/kubernetes"
  version = "3.1.1"

  chart_version = "1.19.1" # Release date: 15 Oct, 2025

  cluster_issuer_email = "postmaster [at] sabourau.lt" # Replace email address

  # # See comment above about compatibility issue
  # additional_set = [
  #   {
  #     name  = "config.featureGates.ACMEHTTP01IngressPathTypeExact"
  #     value = false
  #   }
  # ]
}
