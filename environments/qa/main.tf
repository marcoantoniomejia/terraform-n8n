# environments/qa/main.tf

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "gke_cluster" {
  source = "../../modules/gke"

  name_prefix      = "qa"
  project_id       = var.gcp_project_id
  region           = var.gcp_region
  network_name     = "default"
  subnetwork_name  = "default"

  # --- Configuración específica para QA (Regional) ---
  machine_type       = "n2d-standard-4"
  disk_size_gb       = 10
  disk_type          = "pd-balanced"
  enable_autoscaling = true
  min_node_count     = 1
  max_node_count     = 3
  node_locations     = var.gcp_node_locations
}