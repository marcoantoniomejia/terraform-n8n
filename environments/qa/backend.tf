terraform {
  backend "gcs" {
    # REEMPLAZA ESTO con el nombre del bucket generado por 'bootstrap' para el entorno de qa.
    # Ejemplo: bucket = "gcs-tfstate-psa-td-corp-transf-n8n-qa"
    prefix = "qa/gke"
  }
}