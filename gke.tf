resource "google_container_cluster" "default" {
  project  = var.project_id
  name     = "standard-cluster"
  location = var.region

  networking_mode = "VPC_NATIVE"
  network         = "projects/${var.project_id}/global/networks/default"
  subnetwork      = "projects/${var.project_id}/regions/${var.region}/subnetworks/default"

  deletion_protection = false
  initial_node_count  = 3

  release_channel {
    channel = "REGULAR"
  }

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-balanced"
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-medium"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    service_account = "default"

    advanced_machine_features {
      enable_nested_virtualization = false
      threads_per_core             = 0
    }

    boot_disk {
      disk_type = "pd-balanced"
      size_gb   = 100
    }

    ephemeral_storage_local_ssd_config {
      data_cache_count = 0
      local_ssd_count  = 0
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  dns_config {
    cluster_dns = "PROVIDER_UNSPECIFIED"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  lifecycle {
    ignore_changes = [
      node_pool,
      dns_config,
    ]
  }
}
