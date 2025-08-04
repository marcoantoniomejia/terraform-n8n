# environments/prod/backend.tf

terraform {
  backend "gcs" {
    bucket = "tu-bucket-para-tfstate" # ¡Usa el mismo bucket que en dev!
    prefix = "gke/prod"               # Un prefijo diferente para aislar el estado de prod
  }
}