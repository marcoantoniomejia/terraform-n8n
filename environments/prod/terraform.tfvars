gcp_project_id = "psa-td-corp-transf-n8n-prd"
gcp_env        = "prod"
gcp_region     = "us-west2"

# --- Configuración de Red para GKE en PROD (Shared VPC) ---
gke_network_project_id   = "psa-cld-red-prd"
gke_network_name         = "psa-cld-red-vpc-prd"
gke_node_pool_subnet     = "subnet-trans-n8n-prd-01"
gke_control_plane_subnet = "subnet-trans-n8n-prd-02"
gke_master_ipv4_cidr_block = "172.30.46.0/28"
gke_master_authorized_networks = [
  {
    display_name = "gke-nodes-subnet-prod",
    cidr_block   = "172.30.45.0/24"
  }
]


# --- Configuración de Recursos Adicionales ---
artifact_registry_repository_name = "n8n-artifacts-prod"

# --- Configuración de Discos Regionales para PROD ---
app_disk_name                 = "n8dappprd"
app_disk_size_gb              = 10
db_disk_name                  = "psgdataprd"
db_disk_size_gb               = 150
regional_disk_type            = "pd-balanced"
regional_disk_replica_zones   = ["us-west2-a", "us-west2-b"]

# --- Configuración del Node Pool de GKE para PROD ---
gke_machine_type   = "n2d-standard-8"
gke_min_node_count = 1
gke_max_node_count = 3
gke_disk_type      = "pd-ssd"
gke_disk_size_gb   = 30
