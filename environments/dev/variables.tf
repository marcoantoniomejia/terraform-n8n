# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\dev\variables.tf

variable "gcp_project_id" {
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

variable "disk_1_zone" {
  description = "La zona de disponibilidad para el primer disco persistente."
  type        = string
  default     = "us-west2-a"
}

variable "disk_2_zone" {
  description = "La zona de disponibilidad para el segundo disco persistente."
  type        = string
  default     = "us-west2-b"
}
