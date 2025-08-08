# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\dev\variables.tf

variable "gcp_project_idXXX" {
  description = "El ID del proyecto de Google Cloud (Service Project) donde se desplegará el clúster GKE."
  type        = string
}

variable "gcp_region" {
  description = "La región donde se desplegarán los recursos."
  type        = string
  default     = "us-west2"
}

variable "gke_network_project_id" {
  description = "El ID del proyecto Host de la VPC compartida."
  type        = string
}

variable "gke_node_pool_subnet" {
  description = "El nombre de la subred en la VPC compartida para los nodos del clúster GKE."
  type        = string
}

variable "gke_control_plane_subnet" {
  description = "El nombre de la subred en la VPC compartida para el plano de control del clúster GKE (debe ser /28)."
  type        = string
}

variable "artifact_registry_repository_name" {
  description = "Nombre para el repositorio de Artifact Registry."
  type        = string
}

variable "app_disk_name" {
  description = "Nombre para el disco de la aplicación (n8n)."
  type        = string
}

variable "app_disk_size" {
  description = "Tamaño en GB para el disco de la aplicación."
  type        = number
}

variable "db_disk_name" {
  description = "Nombre para el disco de la base de datos (PostgreSQL)."
  type        = string
}

variable "db_disk_size" {
  description = "Tamaño en GB para el disco de la base de datos."
  type        = number
}

variable "regional_disk_type" {
  description = "Tipo de disco regional a utilizar (ej. pd-balanced)."
  type        = string
}

variable "regional_disk_replica_zones" {
  description = "Lista de dos zonas para la replicación del disco regional."
  type        = list(string)
}

# --- Configuración del Node Pool de GKE ---

variable "gke_machine_type" {
  description = "El tipo de máquina para los nodos del clúster GKE."
  type        = string
}

variable "gke_min_node_count" {
  description = "El número mínimo de nodos para el autoscaling del clúster."
  type        = number
}

variable "gke_max_node_count" {
  description = "El número máximo de nodos para el autoscaling del clúster."
  type        = number
}

variable "gke_disk_type" {
  description = "El tipo de disco de arranque para los nodos (ej. pd-standard, pd-ssd)."
  type        = string
}

variable "gke_disk_size_gb" {
  description = "El tamaño en GB del disco de arranque para los nodos."
  type        = number
}
