# environments/dev/main.tf

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "gke_service_account" {
  source = "../../modules/gke_service_account"

  project_id  = var.gcp_project_id
  name_prefix = "dev"
}

module "gke_cluster" {
  source = "../../modules/gke"

  name_prefix      = "dev"
  project_id       = var.gcp_project_id
  region           = var.gcp_region
  network_name     = "default" # O el nombre de tu VPC existente
  subnetwork_name  = "default" # O el nombre de tu subred existente

  # --- Configuración específica para Desarrollo ---
  machine_type       = "n2d-standard-4"
  disk_size_gb       = 10
  disk_type          = "pd-balanced" # Balanced Persistent Disk
  enable_autoscaling = true
  min_node_count     = 1
  max_node_count     = 3
  node_service_account_email = module.gke_service_account.email
}

module "n8napp_disk_dev" {
  source = "../../modules/regional_persistent_disk"

  project_id    = var.gcp_project_id
  region        = var.gcp_region
  replica_zones = var.gcp_replica_zones
  disk_name     = "n8nappdev"
  disk_type     = "pd-balanced"
  disk_size_gb  = 10
}

module "psgdata_disk_dev" {
  source = "../../modules/regional_persistent_disk"

  project_id    = var.gcp_project_id
  region        = var.gcp_region
  replica_zones = var.gcp_replica_zones
  disk_name     = "psgdatadev"
  disk_type     = "pd-balanced"
  disk_size_gb  = 70
}

module "artifact_registry" {
  source = "../../modules/artifact_registry"

  project_id  = var.gcp_project_id
  region      = var.gcp_region
  name_prefix = "dev"
}
