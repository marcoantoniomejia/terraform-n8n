# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\modules\gcs_backend\variables.tf

variable "project_id" {
  description = "El ID del proyecto de GCP donde se creará el bucket para el backend."
  type        = string
}

variable "location" {
  description = "La ubicación donde se creará el bucket. Debe ser una multiregión como 'US' o una región como 'US-CENTRAL1'."
  type        = string
  default     = "US-CENTRAL1"
}

variable "bucket_name_prefix" {
  description = "Prefijo para el nombre del bucket de tfstate. El nombre final será '<prefix>-<project_id>'."
  type        = string
  default     = "tfstate"
}