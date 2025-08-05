# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\qa\main.tf

terraform {
  # La configuración del backend se llena con el output del 'bootstrap'
  backend "gcs" {
    bucket = "gcs-tfstate-psa-td-corp-transf-n8n-qa" # Reemplazar con el output del bootstrap
    prefix = "qa/gke"
  }

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

# Ejemplo de un módulo de GKE que usa las variables de Shared VPC
module "gke_cluster" {
  # La ruta al módulo puede variar según tu estructura
  source = "../../modules/gke_cluster"

  project_id = var.gcp_project_id
  name       = "gke-n8n-cluster-qa"
  location   = var.gcp_region

  # --- Configuración de Red para Shared VPC ---
  network_project_id = var.gke_network_project_id
  subnetwork         = var.gke_node_pool_subnet

  # Configuración para un clúster privado, que es una mejor práctica
  private_cluster_config = {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = data.google_compute_subnet.control_plane_subnet.ip_cidr_range
  }

  # Aquí irían otras configuraciones del clúster...
}
