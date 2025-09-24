# =================================================================================================
# Módulo Terraform para crear un repositorio en Google Artifact Registry.
#
# Este módulo se encarga de provisionar un repositorio de tipo Docker, ideal para almacenar
# las imágenes de contenedor de las aplicaciones.
# =================================================================================================

# modules/artifact_registry/main.tf

resource "google_artifact_registry_repository" "repository" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_name
  description   = "Repositorio Docker para imágenes de la aplicación"
  format        = "DOCKER"
}