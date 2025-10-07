gcp_project_id = "psa-td-corp-transf-n8n-qa"
gcp_env        = "qa"

# --- Configuración de Red para GKE en QA (Shared VPC) ---
gke_network_project_id   = "psa-cld-red-qa"
gke_network_name         = "psa-cld-red-vpc-qa"
gke_node_pool_subnet     = "subnet-trans-n8n-qas-01"
gke_control_plane_subnet = "subnet-trans-n8n-qas-02"

# --- Configuración de Recursos Adicionales ---
artifact_registry_repository_name = "n8n-artifacts-qa"

# --- Configuración de Discos Regionales para QA ---
app_disk_name                 = "n8dappqa"
app_disk_size_gb              = 10
db_disk_name                  = "psgdataqa"
db_disk_size_gb               = 70
regional_disk_type            = "pd-balanced"
regional_disk_replica_zones   = ["us-west2-a", "us-west2-b"]

# --- Configuración del Node Pool de GKE para QA ---
gke_machine_type   = "n2d-standard-4"
gke_min_node_count = 1
gke_max_node_count = 3
gke_disk_type      = "pd-ssd"
gke_disk_size_gb   = 10