# modules/gke_service_account/outputs.tf

output "email" {
  description = "The email of the created GKE service account."
  value       = google_service_account.gke_sa.email
}