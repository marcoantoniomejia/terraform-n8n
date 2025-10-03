# =================================================================================================
# Módulo Terraform para crear un clúster de Google Kubernetes Engine (GKE).
#
# Este módulo provisiona un clúster de GKE con configuraciones avanzadas, incluyendo:
# - Soporte para clústeres privados.
# - Conexión a una Shared VPC.
# - Un node pool con auto-escalado.
# - Habilitación de las APIs necesarias para GKE.
# =================================================================================================

# modules/gke/main.tf

resource "google_container_cluster" "primary" {
  name     = "${var.name_prefix}-gke-cluster"
  location = var.region
  project  = var.project_id
  deletion_protection = false

  # Habilitar Logging y Monitoring para el clúster
  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service

  # Lógica para Shared VPC: si se provee un network_project_id, se construye la URL completa.
  # Si no, se asume que la red está en el mismo proyecto.
  network    = var.network_project_id == null ? var.network_name : "projects/${var.network_project_id}/global/networks/${var.network_name}"
  subnetwork = var.network_project_id == null ? var.subnetwork_name : "projects/${var.network_project_id}/regions/${var.region}/subnetworks/${var.subnetwork_name}"

  # Configuración de clúster privado (si se proporciona)
  dynamic "private_cluster_config" {
    for_each = var.private_cluster_config != null ? [var.private_cluster_config] : []
    content {
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      master_ipv4_cidr_block  = private_cluster_config.value.master_ipv4_cidr_block
    }
  }

 ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods-range-n8n"
    services_secondary_range_name = "gke-services-range-n8n"
  }

    master_authorized_networks_config {
    cidr_blocks {
        display_name = "gke-nodes-subnet"
        cidr_block   = "172.29.47.0/24"
       }
     cidr_blocks {
        display_name = "management-bastion-host"
        cidr_block   = "172.29.48.0/28"
       }      
  }

  initial_node_count = 1
  remove_default_node_pool = true
}

/*
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.name_prefix}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  project    = var.project_id
  node_locations = var.node_locations

  # Si el autoscaling está habilitado, no definimos un conteo fijo de nodos.
  # Si está deshabilitado, usamos el conteo inicial.
  node_count = var.enable_autoscaling ? null : var.initial_node_count

  # Bloque dinámico que se añade solo si var.enable_autoscaling es true
  dynamic "autoscaling" {
    for_each = var.enable_autoscaling ? [1] : []
    content {
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
    }
  }



  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
    # Usar la cuenta de servicio dedicada en lugar de los scopes de OAuth
    service_account = var.node_service_account_email
  }
}
*/