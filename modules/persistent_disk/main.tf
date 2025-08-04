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