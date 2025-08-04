# modules/artifact_registry/variables.tf

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region for the repository."
  type        = string
}

variable "name_prefix" {
  description = "A prefix for the repository name (e.g., 'dev', 'prod')."
  type        = string
}