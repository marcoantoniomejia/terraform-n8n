data "google_project" "project" {}

resource "google_project_iam_member" "gke_service_agent" {
  project = var.gke_network_project_id
  role    = "roles/container.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "gke_node_service_agent" {
  project = var.gke_network_project_id
  role    = "roles/container.nodeService"
  member  = "serviceAccount:${module.gke_node_sa.email}"
}