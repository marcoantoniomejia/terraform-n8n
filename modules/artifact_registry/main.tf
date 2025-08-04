# modules/artifact_registry/main.tf

resource "google_project_service" "apis" {
  project                    = var.project_id
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = true
}

resource "google_artifact_registry_repository" "repository" {
  project       = var.project_id
  location      = var.region
  repository_id = "${var.name_prefix}-repo"
  description   = "Docker repository for ${var.name_prefix} environment"
  format        = "DOCKER"
  depends_on    = [google_project_service.apis]
}