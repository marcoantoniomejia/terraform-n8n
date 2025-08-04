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
  description = "The name of the subnetwork."
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
