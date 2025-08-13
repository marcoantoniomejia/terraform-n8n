data "google_project" "project" {}

resource "google_project_iam_member" "gke_service_agent" {
  project = data.google_project.project.project_id
  role    = "roles/container.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.project.number}@container-engine-robot.iam.gserviceaccount.com"
}
