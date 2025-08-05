# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\bootstrap\variables.tf

variable "gcp_project_id" {
  description = "El ID del proyecto de Google Cloud donde se creará el bucket de backend."
  type        = string
}

variable "gcp_region" {
  description = "La región donde se creará el bucket de backend."
  type        = string
  default     = "US-CENTRAL1"
}