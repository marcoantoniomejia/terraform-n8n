# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\prd\backend.tf

terraform {
  backend "gcs" {
    # REEMPLAZA ESTO con el nombre del bucket generado por 'bootstrap' para el entorno de prod.
    # Ejemplo: bucket = "gcs-tfstate-psa-td-corp-transf-n8n-prd"
    prefix = "prd/gke"
  }
}