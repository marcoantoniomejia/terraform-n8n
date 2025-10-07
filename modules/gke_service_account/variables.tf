variable "project_id" {
  description = "The GCP project ID where the service account will be created."
  type        = string
}

variable "name_prefix" {
  description = "A prefix for the service account name."
  type        = string
}

variable "network_project_id" {
  description = "The GCP project ID of the host network project."
  type        = string
}
