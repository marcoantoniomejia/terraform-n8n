# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\bootstrap\main.tf

terraform {
  # Durante la fase de bootstrap, el estado se gestiona localmente.
  # Este es el único lugar donde se usará un backend local.
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
}

module "gcs_backend_bucket" {
  source = "../modules/gcs_backend"

  project_id = var.gcp_project_id
  location   = var.gcp_region
}