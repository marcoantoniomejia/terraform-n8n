# environments/qa/backend.tf

terraform {
  backend "gcs" {
    bucket = "tfstate-bucket-n8n-infra-unico" # <-- REEMPLAZA ESTO con el nombre de tu bucket
    prefix = "gke/qa"                 # Un prefijo diferente para aislar el estado de QA
  }
}