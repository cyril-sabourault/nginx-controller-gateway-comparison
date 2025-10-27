
resource "google_compute_address" "nginx_load_balancer_ip" {
  name   = "nginx-external-ip"
  region = var.region

  address_type = "EXTERNAL"
}

resource "google_compute_address" "gateway_load_balancer_ip" {
  name   = "gateway-external-ip"
  region = var.region

  purpose = "SHARED_LOADBALANCER_VIP"
}
