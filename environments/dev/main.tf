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

locals {
  # Define la configuración para los discos regionales en un mapa.
  # Esto permite crear múltiples discos usando for_each, evitando la duplicación de código.
  regional_disks = {
    app = {
      name = var.app_disk_name
      size = var.app_disk_size_gb
    },
    db = {
      name = var.db_disk_name
      size = var.db_disk_size_gb
    }
  }
}

# Obtenemos los detalles de la subred del plano de control para extraer su rango CIDR.
# Google Cloud requiere un rango /28 para el plano de control de GKE.
data "google_compute_subnetwork" "control_plane_subnet" {
  project = var.gke_network_project_id
  name    = var.gke_control_plane_subnet
  region  = var.gcp_region
}

# Módulo de GKE que usa las variables de Shared VPC para el entorno de DEV
module "gke_cluster" {
  source = "../../modules/gke_cluster"

  # --- Parámetros del Clúster ---
  name_prefix = "gke-n8n-cluster-dev"
  project_id  = var.gcp_project_id
  region      = var.gcp_region

  # --- Configuración de Red (Shared VPC) ---
  # El módulo ahora soporta Shared VPC y clúster privado
  network_project_id = var.gke_network_project_id
  network_name       = var.gke_network_name
  subnetwork_name    = var.gke_node_pool_subnet # Subnet para los nodos

  # --- Configuración de Clúster Privado ---
  # Se pasa la configuración del clúster privado, incluyendo el CIDR del plano de control
  private_cluster_config = {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = data.google_compute_subnetwork.control_plane_subnet.ip_cidr_range
  }

  # --- Configuración del Node Pool ---
  machine_type     = var.gke_machine_type
  disk_type        = var.gke_disk_type
  disk_size_gb     = var.gke_disk_size_gb
  enable_autoscaling = true
  min_node_count     = var.gke_min_node_count
  max_node_count     = var.gke_max_node_count
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
# REFACTORIZADO: Se utiliza el módulo 'regional_persistent_disk' con for_each.
# Esto elimina el código duplicado y se alinea con las mejores prácticas de modularidad.
module "regional_disks" {
  source = "../../modules/regional_persistent_disk"
  for_each = local.regional_disks

  project_id    = var.gcp_project_id
  region        = var.gcp_region
  disk_name     = each.value.name
  disk_size_gb  = each.value.size
  disk_type     = var.regional_disk_type
  replica_zones = var.regional_disk_replica_zones
}