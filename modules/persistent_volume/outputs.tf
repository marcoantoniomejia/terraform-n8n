
output "disk_name" {
  description = "The name of the created regional persistent disk."
  value       = google_compute_region_disk.disk.name
}

output "pv_name" {
  description = "The name of the created PersistentVolume."
  value       = kubernetes_persistent_volume.pv.metadata.0.name
}
