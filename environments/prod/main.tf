# environments/prod/main.tf

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "gke_cluster" {
  source = "../../modules/gke"

  name_prefix     = "prod"
  project_id      = var.gcp_project_id
  region          = var.gcp_region
  network_name    = "default" # O el nombre de tu VPC de producción
  subnetwork_name = "default" # O el nombre de tu subred de producción

  # --- Configuración específica para Producción ---
  machine_type       = "n2d-standard-8"
  disk_size_gb       = 10
  disk_type          = "pd-ssd"
  enable_autoscaling = true
  min_node_count     = 1
  max_node_count     = 3
}

module "n8napp_disk" {
  source = "../../modules/persistent_disk"

  project_id   = var.gcp_project_id
  zone         = var.gcp_zone
  disk_name    = "prod-n8napp-disk"
  disk_type    = "pd-ssd"
  disk_size_gb = 10
}

module "psgdata_disk" {
  source = "../../modules/persistent_disk"

  project_id   = var.gcp_project_id
  zone         = var.gcp_zone
  disk_name    = "prod-psgdata-disk"
  disk_type    = "pd-ssd"
  disk_size_gb = 10
}