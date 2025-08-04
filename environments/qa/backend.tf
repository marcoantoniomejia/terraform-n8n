# environments/qa/backend.tf

terraform {
  backend "gcs" {
    bucket = "tu-bucket-para-tfstate" # ¡Usa el mismo bucket que en dev y prod!
    prefix = "gke/qa"                 # Un prefijo diferente para aislar el estado de QA
  }
}