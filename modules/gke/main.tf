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
  node_count = var.initial_node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
