data "google_project" "project" {}

resource "google_project_iam_member" "gke_service_agent" {
  project = var.gke_network_project_id
  role    = "roles/container.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "gke_node_logging_writer" {
  project = var.gke_network_project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${module.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_monitoring_writer" {
  project = var.gke_network_project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${module.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_monitoring_viewer" {
  project = var.gke_network_project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${module.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_default_node_service_account" {
  project = var.gke_network_project_id
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${module.gke_node_sa.email}"
}