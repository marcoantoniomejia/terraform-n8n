# modules/persistent_disk/outputs.tf

output "name" {
  description = "The name of the created persistent disk."
  value       = google_compute_disk.disk.name
}

output "self_link" {
  description = "The self-link of the persistent disk, useful for Kubernetes PVs."
  value       = google_compute_disk.disk.self_link
}