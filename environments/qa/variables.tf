variable "gcp_project_id" {
  description = "El ID del proyecto de GCP."
  type        = string
}

variable "gcp_env" {
  description = "El entorno de despliegue (e.g., qa, dev, prd)."
  type        = string
}

variable "gcp_region" {
  description = "La región de GCP para el despliegue."
  type        = string
}

variable "gke_network_project_id" {
  description = "El ID del proyecto Host de la VPC compartida."
  type        = string
}

variable "gke_network_name" {
  description = "El nombre de la red VPC compartida."
  type        = string
}

variable "gke_node_pool_subnet" {
  description = "El nombre de la subred para los nodos de GKE."
  type        = string
}

variable "gke_control_plane_subnet" {
  description = "El nombre de la subred para el plano de control de GKE."
  type        = string
}

variable "gke_master_ipv4_cidr_block" {
  description = "El bloque CIDR para el plano de control de GKE."
  type        = string
}

variable "gke_master_authorized_networks" {
  description = "Lista de bloques CIDR autorizados para acceder al master de GKE."
  type = list(object({
    display_name = string
    cidr_block   = string
  }))
  default = []
}

variable "artifact_registry_repository_name" {
  description = "El nombre del repositorio de Artifact Registry."
  type        = string
}

variable "app_disk_name" {
  description = "Nombre del disco para la aplicación."
  type        = string
}

variable "app_disk_size_gb" {
  description = "Tamaño en GB del disco para la aplicación."
  type        = number
}

variable "db_disk_name" {
  description = "Nombre del disco para la base de datos."
  type        = string
}

variable "db_disk_size_gb" {
  description = "Tamaño en GB del disco para la base de datos."
  type        = number
}

variable "regional_disk_type" {
  description = "Tipo de disco regional."
  type        = string
}

variable "regional_disk_replica_zones" {
  description = "Zonas de réplica para el disco regional."
  type        = list(string)
}

variable "gke_machine_type" {
  description = "Tipo de máquina para los nodos de GKE."
  type        = string
}

variable "gke_min_node_count" {
  description = "Número mínimo de nodos para el autoscaling."
  type        = number
}

variable "gke_max_node_count" {
  description = "Número máximo de nodos para el autoscaling."
  type        = number
}

variable "gke_disk_type" {
  description = "Tipo de disco para los nodos de GKE."
  type        = string
}

variable "gke_disk_size_gb" {
  description = "Tamaño en GB del disco para los nodos de GKE."
  type        = number
}