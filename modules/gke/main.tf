# modules/gke/main.tf

resource "google_container_cluster" "primary" {
  name     = "${var.name_prefix}-gke-cluster"
  location = var.region
  project  = var.project_id

  # Como es un proyecto existente, asumimos que la red ya existe.
  network    = var.network_name
  subnetwork = var.subnetwork_name

  initial_node_count = 1
  remove_default_node_pool = true
}

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
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
