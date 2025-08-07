# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\qa\main.tf

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

# Módulo de GKE que usa las variables de Shared VPC para el entorno de QA
module "gke_cluster" {
  source = "../../modules/gke_cluster"

  project_id = var.gcp_project_id
  name       = "gke-n8n-cluster-qa" # Nombre específico para QA
  location   = var.gcp_region

  # --- Configuración de Red para Shared VPC ---
  network_project_id = var.gke_network_project_id
  subnetwork         = var.gke_node_pool_subnet

  private_cluster_config = {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = data.google_compute_subnet.control_plane_subnet.ip_cidr_range
  }

  # --- Configuración del Node Pool ---
  node_config = {
    machine_type = var.gke_machine_type
    disk_type    = var.gke_disk_type
    disk_size_gb = var.gke_disk_size_gb
  }

  # --- Configuración de Autoescalado ---
  autoscaling = {
    min_node_count = var.gke_min_node_count
    max_node_count = var.gke_max_node_count
  }
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

# --- Discos Regionales para QA ---

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
