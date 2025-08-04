# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\modules\gcs_backend\outputs.tf

output "bucket_name" {
  description = "El nombre del bucket de GCS creado para almacenar el estado de Terraform."
  value       = google_storage_bucket.tfstate.name
}