# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\prd\outputs.tf

output "gke_cluster_name" {
  description = "Name of the GKE cluster for the Production environment."
  value       = module.gke_cluster.cluster_name
}

output "artifact_registry_repository_name" {
  description = "Nombre completo del repositorio de Artifact Registry."
  value       = module.artifact_registry.name
}

output "app_disk_self_link" {
  description = "Self-link del disco regional de la aplicación."
  value       = google_compute_region_disk.app_disk.self_link
}

output "db_disk_self_link" {
  description = "Self-link del disco regional de la base de datos."
  value       = google_compute_region_disk.db_disk.self_link
}
