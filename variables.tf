variable "project_id" {
  type        = string
  description = "GCP Project ID where resources will be created"
}

variable "region" {
  type        = string
  default     = "europe-west1"
  description = "GCP region where resources will be created"
}

