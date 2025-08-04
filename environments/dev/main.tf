# environments/dev/main.tf

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "gke_cluster" {
  source = "../../modules/gke"

  name_prefix      = "dev"
  project_id       = var.gcp_project_id
  region           = var.gcp_region
  network_name     = "default" # O el nombre de tu VPC existente
  subnetwork_name  = "default" # O el nombre de tu subred existente
  machine_type     = "e2-medium"
  initial_node_count = 1
}
