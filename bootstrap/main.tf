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
      version = ">= 4.50.0" # Required for GKE and other resources
    }
  }
}

locals {
  project_ids = {
    "dev" = "psa-td-corp-transf-n8n-dev",
    "qa"  = "psa-td-corp-transf-n8n-qa",
    "prd" = "psa-td-corp-transf-n8n-prd"
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "gcs_backend_bucket" {
  source = "../modules/gcs_backend"

  project_id = var.gcp_project_id
  location   = var.gcp_region
}