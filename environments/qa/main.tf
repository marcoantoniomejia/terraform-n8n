# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\qa\main.tf

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



# Módulo para crear la cuenta de servicio dedicada para los nodos de GKE
module "gke_node_sa" {
  source      = "../../modules/gke_service_account"
  project_id  = var.gcp_project_id
  name_prefix = "qa"
}

# Módulo de GKE que usa las variables de Shared VPC para el entorno de QA
module "gke_cluster" {
  source = "../../modules/gke_cluster"

  # --- Parámetros del Clúster ---
  name_prefix = "gke-n8n-cluster-qa" # Nombre específico para QA
  project_id  = var.gcp_project_id
  region      = var.gcp_region
  node_service_account_email = module.gke_node_sa.email

  # --- Configuración de Red (Shared VPC) ---
  network_project_id = var.gke_network_project_id
  network_name       = var.gke_network_name
  subnetwork_name    = var.gke_node_pool_subnet # Subnet para los nodos

  # --- Configuración de Clúster Privado ---
  private_cluster_config = {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.29.46.0/28"
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

# Habilitar la API de Cloud Billing
resource "google_project_service" "cloudbilling" {
  project            = var.gcp_project_id
  service            = "cloudbilling.googleapis.com"
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
  host                   = "https://${module.gke_cluster.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca_certificate)
}

# --- Persistent Volumes ---

/*
module "app_persistent_volume" {
  source = "../../modules/persistent_volume"

  gcp_project_id     = var.gcp_project_id
  gcp_region         = var.gcp_region
  disk_name          = var.app_disk_name
  disk_type          = var.regional_disk_type
  disk_size_gb       = var.app_disk_size_gb
  disk_replica_zones = var.regional_disk_replica_zones
  pv_name            = "n8n-app-data-pv-qa"
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
  pv_name            = "n8n-db-data-pv-qa"
  pv_role            = "db-data"
}
*/

# Regla de Firewall para permitir la comunicación desde el plano de control de GKE a los nodos.
# Esto es mandatorio para los clústeres privados.
resource "google_compute_firewall" "gke_master_to_nodes_allow" {
  # Esta regla debe crearse en el proyecto HOST de la Shared VPC
  project = var.gke_network_project_id

  name    = "${var.gcp_env}-gke-master-to-nodes-allow"
  network = var.gke_network_name

  # Permitir tráfico desde el CIDR del master de GKE
  source_ranges = ["172.29.46.0/28"]

  # Aplicar a los nodos que usan la cuenta de servicio de GKE
  target_service_accounts = [module.gke_node_sa.email]

  allow {
    protocol = "tcp"
    ports    = ["443", "10250"] # Puerto para Konnectivity y Kubelet
  }
}
