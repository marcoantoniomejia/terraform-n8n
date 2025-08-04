# modules/gke_service_account/main.tf

resource "google_service_account" "gke_sa" {
  project      = var.project_id
  account_id   = "${var.name_prefix}-gke-sa"
  display_name = "Service Account for ${var.name_prefix} GKE Cluster"
}

# Permisos para que los nodos puedan enviar logs
resource "google_project_iam_member" "logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

# Permisos para que los nodos puedan enviar métricas
resource "google_project_iam_member" "monitoring" {
  project = var.project_id
  role    = "roles/monitoring.viewer" # monitoring.viewer es suficiente para el agente
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

# Permisos para que los nodos puedan extraer imágenes de Artifact Registry
resource "google_project_iam_member" "artifact_registry" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}