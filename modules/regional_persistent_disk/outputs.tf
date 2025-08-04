# modules/regional_persistent_disk/outputs.tf

output "name" {
  description = "The name of the created regional persistent disk."
  value       = google_compute_region_disk.disk.name
}

output "self_link" {
  description = "The self-link of the regional persistent disk, useful for Kubernetes PVs."
  value       = google_compute_region_disk.disk.self_link
}