# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\dev\backend.tf

terraform {
  backend "gcs" {
    # REEMPLAZA ESTO con el nombre del bucket generado por 'bootstrap' para el entorno de dev.
    # Ejemplo: bucket = "gcs-tfstate-psa-td-corp-transf-n8n-dev"
    prefix = "dev/gke"
  }
}