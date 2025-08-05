gcp_project_id = "psa-td-corp-transf-n8n-prd"

# --- Configuración de Red para GKE en Prod (Shared VPC) ---
gke_network_project_id   = "tu-gcp-host-project-id-aqui" # ¡IMPORTANTE! Reemplaza con el ID del proyecto Host de la VPC.
gke_node_pool_subnet     = "subnet-trans-n8n-prd-01"
gke_control_plane_subnet = "subnet-trans-n8n-prd-02"
