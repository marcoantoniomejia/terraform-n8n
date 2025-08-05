# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\bootstrap\outputs.tf

output "tfstate_bucket_name" {
  description = "El nombre del bucket de GCS para el backend de Terraform. Copia este valor en los archivos backend.tf de tus entornos."
  value       = module.gcs_backend_bucket.bucket_name
}