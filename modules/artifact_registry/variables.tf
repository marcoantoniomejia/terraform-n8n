# modules/artifact_registry/variables.tf

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "location" {
  description = "The GCP location (region) for the repository."
  type        = string
}

variable "repository_name" {
  description = "El nombre para el repositorio de Artifact Registry."
  type        = string
}