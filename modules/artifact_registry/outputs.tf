# modules/artifact_registry/outputs.tf

output "repository_url" {
  description = "La URL completa del repositorio de Artifact Registry."
  value       = "${var.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repository.repository_id}"
}

output "repository_id" {
  description = "The ID of the Artifact Registry repository."
  value       = google_artifact_registry_repository.repository.repository_id
}