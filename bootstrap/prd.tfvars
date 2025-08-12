gcp_project_id = "psa-td-corp-transf-n8n-prd"

# --- Configuración de Red para GKE en Prod (Shared VPC) ---
gke_network_project_id   = "psa-cld-red-prd"
gke_network_name         = "psa-cld-red-vpc-prd"
gke_node_pool_subnet     = "subnet-trans-n8n-prd-01"
gke_control_plane_subnet = "subnet-trans-n8n-prd-02"

# --- Configuración de Recursos Adicionales ---
artifact_registry_repository_name = "n8n-artifacts-prd"

# --- Configuración de Discos Regionales para Producción ---
app_disk_name                 = "n8dapp"
app_disk_size                 = 10
db_disk_name                  = "psgdata"
db_disk_size                  = 100
regional_disk_type            = "pd-regional-ssd"
regional_disk_replica_zones   = ["us-west2-a", "us-west2-b"]

# --- Configuración del Node Pool de GKE para Producción ---
gke_machine_type   = "n2d-standard-8"
gke_min_node_count = 1
gke_max_node_count = 3
gke_disk_type      = "pd-ssd"
gke_disk_size_gb   = 10