# modules/gke_service_account/variables.tf

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "name_prefix" {
  description = "A prefix for the service account name (e.g., 'dev', 'prod')."
  type        = string
}