
variable "project_id" {
  description = "El ID del proyecto de GCP donde se creará el bastión."
  type        = string
}

variable "zone" {
  description = "La zona de GCP donde se desplegará el bastión."
  type        = string
}

variable "instance_name" {
  description = "El nombre de la instancia del bastión."
  type        = string
  default     = "management-bastion-host"
}

variable "machine_type" {
  description = "El tipo de máquina para la instancia del bastión."
  type        = string
  default     = "e2-small"
}

variable "network_name" {
  description = "El nombre de la red VPC a la que se conectará el bastión."
  type        = string
}

variable "subnetwork_name" {
  description = "El nombre de la subred a la que se conectará el bastión."
  type        = string
}

variable "service_account_email" {
  description = "El correo electrónico de la cuenta de servicio que utilizará el bastión."
  type        = string
}
