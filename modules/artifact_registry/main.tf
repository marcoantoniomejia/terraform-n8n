# modules/artifact_registry/main.tf

resource "google_artifact_registry_repository" "repository" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_name
  description   = "Repositorio Docker para imágenes de la aplicación"
  format        = "DOCKER"
}