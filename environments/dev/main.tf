# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\dev\main.tf

terraform {
  # La configuración del backend remoto se define en el archivo backend.tf
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Obtenemos los detalles de la subred del plano de control para extraer su rango CIDR.
# Google Cloud requiere un rango /28 para el plano de control de GKE.
data "google_compute_subnet" "control_plane_subnet" {
  project = var.gke_network_project_id
  name    = var.gke_control_plane_subnet
  region  = var.gcp_region
}

# Módulo de GKE que usa las variables de Shared VPC para el entorno de DEV
module "gke_cluster" {
  source = "../../modules/gke_cluster"

  project_id = var.gcp_project_id
  # The 'location' attribute is not expected here. It should be passed to the module directly if needed.
  # location   = var.gcp_region
  region = var.gcp_region

  name_prefix = "dev" # Hardcoded prefix for dev environment
  # --- Configuración de Red para Shared VPC ---
  network_name = var.gke_network_project_id # This should be the network name, not project ID
  subnetwork_name = var.gke_node_pool_subnet

  # --- Configuración del Node Pool (pasado directamente como variables del módulo) ---
  machine_type = var.gke_machine_type
  disk_type    = var.gke_disk_type
  disk_size_gb = var.gke_disk_size_gb
  min_node_count = var.gke_min_node_count
  max_node_count = var.gke_max_node_count
  enable_autoscaling = true # Habilitar autoscaling ya que se especifican min/max
}

# --- Recursos Adicionales ---

# Habilitar la API de Artifact Registry antes de crear el repositorio
resource "google_project_service" "artifactregistry" {
  project            = var.gcp_project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

module "artifact_registry" {
  source        = "../../modules/artifact_registry"
  project_id    = var.gcp_project_id
  location      = var.gcp_region
  repository_name = var.artifact_registry_repository_name
  depends_on    = [google_project_service.artifactregistry]
}

# --- Discos Regionales para Desarrollo ---

resource "google_compute_region_disk" "app_disk" {
  project       = var.gcp_project_id
  name          = var.app_disk_name
  type          = var.regional_disk_type
  region        = var.gcp_region
  size          = var.app_disk_size
  replica_zones = var.regional_disk_replica_zones
}

resource "google_compute_region_disk" "db_disk" {
  project       = var.gcp_project_id
  name          = var.db_disk_name
  type          = var.regional_disk_type
  region        = var.gcp_region
  size          = var.db_disk_size
  replica_zones = var.regional_disk_replica_zones
}
