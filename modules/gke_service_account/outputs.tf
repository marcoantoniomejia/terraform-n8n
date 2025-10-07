output "email" {
  description = "The email of the created service account."
  value       = google_service_account.gke_sa.email
}

output "name" {
  description = "The fully-qualified name of the created service account."
  value       = google_service_account.gke_sa.name
}
