locals {
  cert_domains = toset([
    "gw-cert.sabourau.lt",
  ])
}

resource "google_certificate_manager_certificate_map" "gateway_certificate_map" {
  name        = "gateway-cert-map"
  description = "Certificate map for the Gateway"
}

resource "google_certificate_manager_certificate_map_entry" "default" {
  name        = "gateway-cert-map-entry"
  description = "My certificate map entry"
  map         = google_certificate_manager_certificate_map.gateway_certificate_map.name

  certificates = [google_certificate_manager_certificate.certificate.id]
  matcher      = "PRIMARY"
}

resource "google_certificate_manager_certificate" "certificate" {
  name        = "gw-cert"
  description = "The default cert for gw-cert subdomain"
  scope       = "DEFAULT"

  managed {
    domains = [
      for d in values(google_certificate_manager_dns_authorization.dns_authorizations) :
      d.domain
    ]
    dns_authorizations = [
      for d in values(google_certificate_manager_dns_authorization.dns_authorizations) :
      d.id
    ]
  }
}

resource "google_certificate_manager_dns_authorization" "dns_authorizations" {
  for_each = local.cert_domains

  name   = "${replace(each.value, ".", "-")}-dns-auth"
  domain = each.value
}

