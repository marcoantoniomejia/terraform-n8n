# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\prod\main.tf

terraform {
  # La configuración del backend remoto se define en el archivo backend.tf
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Obtenemos los detalles de la subred del plano de control para extraer su rango CIDR.
# Google Cloud requiere un rango /28 para el plano de control de GKE.
data "google_compute_subnetwork" "control_plane_subnet" {
  project = var.gke_network_project_id
  name    = var.gke_control_plane_subnet
  region  = var.gcp_region
}

# Módulo de GKE que usa las variables de Shared VPC para el entorno de PRD
module "gke_cluster" {
  source = "../../modules/gke_cluster"

  # --- Parámetros del Clúster ---
  name_prefix = "gke-n8n-cluster-prd" # Nombre específico para Prod
  project_id  = var.gcp_project_id
  region      = var.gcp_region

  # --- Configuración de Red (Shared VPC) ---
  network_project_id = var.gke_network_project_id
  network_name       = var.gke_network_name
  subnetwork_name    = var.gke_node_pool_subnet # Subnet para los nodos

  # --- Configuración de Clúster Privado ---
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

# --------------------------------------------------------------------------------
# --- Configuración del Proveedor de Kubernetes y PersistentVolumes (PV) ---
# --------------------------------------------------------------------------------

# Obtenemos la configuración del cliente de gcloud para autenticar el proveedor de Kubernetes.
data "google_client_config" "default" {}

# Configuramos el proveedor de Kubernetes para que se conecte al clúster GKE creado.
# Esto nos permite gestionar recursos de Kubernetes (como PersistentVolumes) con Terraform.
provider "kubernetes" {
  host                   = "https://${module.gke_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca_certificate)
}

# --- Persistent Volumes ---

module "app_persistent_volume" {
  source = "../../modules/persistent_volume"

  gcp_project_id     = var.gcp_project_id
  gcp_region         = var.gcp_region
  disk_name          = var.app_disk_name
  disk_type          = var.regional_disk_type
  disk_size_gb          = var.app_disk_size_gb
  disk_replica_zones = var.regional_disk_replica_zones
  pv_name            = "n8n-app-data-pv-prod"
  pv_role            = "app-data"
}

module "db_persistent_volume" {
  source = "../../modules/persistent_volume"

  gcp_project_id     = var.gcp_project_id
  gcp_region         = var.gcp_region
  disk_name          = var.db_disk_name
  disk_type          = var.regional_disk_type
  disk_size_gb          = var.db_disk_size_gb
  disk_replica_zones = var.regional_disk_replica_zones
  pv_name            = "n8n-db-data-pv-prod"
  pv_role            = "db-data"
}
