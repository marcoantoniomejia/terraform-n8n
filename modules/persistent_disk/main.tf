# =================================================================================================
# Módulo Terraform para crear un Disco Persistente zonal en Google Cloud.
#
# Este módulo provisiona un disco `gce_persistent_disk`, que está vinculado a una zona
# específica. Es ideal para ser usado por una única máquina virtual.
#
# Nota: Para alta disponibilidad, considere usar el módulo `regional_persistent_disk`.
# =================================================================================================

# modules/persistent_disk/main.tf

resource "google_compute_disk" "disk" {
  project = var.project_id
  name    = var.disk_name
  type    = var.disk_type
  zone    = var.zone
  size    = var.disk_size_gb
  labels = {
    managed-by = "terraform"
    purpose    = var.disk_name
  }
}