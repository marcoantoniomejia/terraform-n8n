# environments/prod/terraform.tfvars

gcp_project_id = "tu-proyecto-gcp-existente"

gke_network_project_id     = "tu-proyecto-host-vpc"
gke_node_pool_subnet       = "nombre-subred-nodos"
gke_control_plane_subnet   = "nombre-subred-control-plane"
gke_network_name           = "nombre-vpc-compartida"

artifact_registry_repository_name = "n8n-docker-images"

# --- Configuración de Discos Regionales ---
app_disk_name = "n8n-app-disk-prod"
app_disk_size = 20 # Tamaño de disco para la aplicación (n8n)

db_disk_name = "n8n-db-disk-prod"
db_disk_size_gb = 10 # Tamaño de disco para la base de datos (Postgres)

regional_disk_type          = "pd-balanced"
regional_disk_replica_zones = ["us-west2-a", "us-west2-b"] # Ejemplo, ajusta a tus zonas

# --- Configuración del Node Pool de GKE ---
gke_machine_type = "e2-medium"
gke_min_node_count = 1
gke_max_node_count = 3
gke_disk_type      = "pd-standard"
gke_disk_size_gb   = 50
