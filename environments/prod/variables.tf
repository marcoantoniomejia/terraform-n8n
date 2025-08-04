# environments/prod/variables.tf

variable "gcp_project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the resources."
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "The GCP zone for zonal resources like persistent disks."
  type        = string
  default     = "us-central1-a" # Default to the first zone in the region
}