gcp_project_id = "psa-td-corp-transf-n8n-dev"
gcp_env        = "dev"
gcp_region     = "us-west2"

# --- Configuración de Red para GKE en DEV (Shared VPC) ---
gke_network_project_id   = "psa-cld-red-dev"
gke_network_name         = "psa-cld-red-vpc-dev"
gke_node_pool_subnet     = "subnet-trans-n8n-dev-01"
gke_control_plane_subnet = "subnet-trans-n8n-dev-02"
gke_master_ipv4_cidr_block = "172.28.46.0/28"
gke_master_authorized_networks = [
  {
    display_name = "gke-nodes-subnet-dev",
    cidr_block   = "172.28.45.0/24"
  }
]


# --- Configuración de Recursos Adicionales ---
artifact_registry_repository_name = "n8n-artifacts-dev"

# --- Configuración de Discos Regionales para DEV ---
app_disk_name                 = "n8dappdev"
app_disk_size_gb              = 10
db_disk_name                  = "psgdatadev"
db_disk_size_gb               = 70
regional_disk_type            = "pd-balanced"
regional_disk_replica_zones   = ["us-west2-a", "us-west2-b"]

# --- Configuración del Node Pool de GKE para DEV ---
gke_machine_type   = "n2d-standard-4"
gke_min_node_count = 1
gke_max_node_count = 3
gke_disk_type      = "pd-ssd"
gke_disk_size_gb   = 30