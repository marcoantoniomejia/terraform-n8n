
resource "google_compute_region_disk" "disk" {
  project       = var.gcp_project_id
  name          = var.disk_name
  type          = var.disk_type
  region        = var.gcp_region
  size          = var.disk_size
  replica_zones = var.disk_replica_zones
}

resource "kubernetes_persistent_volume" "pv" {
  metadata {
    name = var.pv_name
    labels = {
      type = "gcp-regional-pd"
      app  = "n8n"
      role = var.pv_role
    }
  }
  spec {
    capacity = {
      storage = "${google_compute_region_disk.disk.size}Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = "n8n-regional-sc"
    persistent_volume_source {
      csi {
        driver        = "pd.csi.storage.gke.io"
        volume_handle = google_compute_region_disk.disk.id
        fs_type       = "ext4"
      }
    }
  }
}
