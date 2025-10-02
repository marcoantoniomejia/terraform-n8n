# =================================================================================================
# Módulo Terraform para crear una Cuenta de Servicio de Google (IAM) para nodos de GKE.
#
# Este módulo provisiona una cuenta de servicio y le asigna los roles esenciales
# para que los nodos de un clúster de GKE puedan operar correctamente:
# - `roles/logging.logWriter`: Para enviar logs a Cloud Logging.
# - `roles/monitoring.viewer`: Para enviar métricas a Cloud Monitoring.
# - `roles/artifactregistry.reader`: Para descargar imágenes de contenedor desde Artifact Registry.
# =================================================================================================

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

# Permisos para que los nodos puedan extraer imágenes de GCR (Google Container Registry)
resource "google_project_iam_member" "gcr_storage_reader" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}