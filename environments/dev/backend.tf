# environments/dev/backend.tf

terraform {
  backend "gcs" {
    bucket = "tu-bucket-para-tfstate" # ¡Este bucket debe existir!
    prefix = "gke/dev"
  }
}
