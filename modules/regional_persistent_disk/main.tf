# modules/regional_persistent_disk/main.tf

resource "google_compute_region_disk" "disk" {
  project       = var.project_id
  name          = var.disk_name
  type          = var.disk_type
  region        = var.region
  size          = var.disk_size_gb
  replica_zones = var.replica_zones
  labels = {
    managed-by = "terraform"
    purpose    = var.disk_name
  }
}