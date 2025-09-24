# =================================================================================================
# Módulo Terraform para crear un bucket en Google Cloud Storage (GCS).
#
# Este módulo está diseñado específicamente para crear el bucket que almacenará el estado
# remoto de Terraform (tfstate). Incluye configuraciones críticas como el versionado
# y la prevención de destrucción para garantizar la seguridad del estado.
# =================================================================================================

# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\modules\gcs_backend\main.tf

resource "google_storage_bucket" "tfstate" {
  project                     = var.project_id
  name                        = "${var.bucket_name_prefix}-${var.project_id}"
  location                    = var.location
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  # Habilitar el versionado es una mejor práctica crítica para los buckets de estado de Terraform.
  # Permite la recuperación en caso de corrupción o eliminación accidental del archivo de estado.
  versioning {
    enabled = true
  }

  # Previene la destrucción accidental del bucket de estado.
  # Si realmente necesitas eliminarlo, debes cambiar esto a 'false' manualmente.
  lifecycle {
    prevent_destroy = true
  }
}
