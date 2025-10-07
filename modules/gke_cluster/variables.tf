# modules/gke/variables.tf

variable "name_prefix" {
  description = "A prefix for all resource names."
  type        = string
}

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the subnetwork for the GKE nodes."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the GKE nodes."
  type        = string
  default     = "e2-standard-2"
}

variable "initial_node_count" {
  description = "The initial number of nodes for the GKE cluster."
  type        = number
  default     = 2
}

variable "enable_autoscaling" {
  description = "Si es true, habilita el autoscaling para el node pool."
  type        = bool
  default     = false
}

variable "min_node_count" {
  description = "Número mínimo de nodos para el autoscaling."
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Número máximo de nodos para el autoscaling."
  type        = number
  default     = 3
}

variable "disk_size_gb" {
  description = "Tamaño del disco de arranque de los nodos en GB."
  type        = number
  default     = 30
}

variable "disk_type" {
  description = "Tipo de disco de arranque. Puede ser 'pd-standard' o 'pd-ssd'."
  type        = string
  default     = "pd-standard"
}

variable "node_locations" {
  description = "The list of zones in which the node pool's nodes should be created. Used for regional clusters."
  type        = list(string)
  default     = null
}

variable "logging_service" {
  description = "The logging service to use. 'logging.googleapis.com/kubernetes' is recommended for GKE."
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = "The monitoring service to use. 'monitoring.googleapis.com/kubernetes' is recommended for GKE."
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "node_service_account_email" {
  description = "The email of the service account to be used by the GKE nodes."
  type        = string
  default     = null # Permite que GKE use la SA por defecto si no se especifica
}

# --- Variables para Shared VPC y Clúster Privado ---

variable "network_project_id" {
  description = "El ID del proyecto Host de la VPC compartida. Si es nulo, se asume que la red está en el mismo proyecto que el clúster."
  type        = string
  default     = null
}

variable "private_cluster_config" {
  description = "Objeto de configuración para crear un clúster privado. Si es nulo, el clúster será público."
  type = object({
    enable_private_endpoint = bool
    enable_private_nodes    = bool
    master_ipv4_cidr_block  = string
  })
  default = null
}

variable "master_authorized_networks" {
  description = "Lista de bloques CIDR autorizados para acceder al master de GKE."
  type = list(object({
    display_name = string
    cidr_block   = string
  }))
  default = []
}