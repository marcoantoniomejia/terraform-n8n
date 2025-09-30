
variable "gcp_project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region."
  type        = string
}

variable "disk_name" {
  description = "The name of the regional persistent disk."
  type        = string
}

variable "disk_type" {
  description = "The type of the regional persistent disk."
  type        = string
}

variable "disk_size" {
  description = "The size of the regional persistent disk in GB."
  type        = number
}

variable "disk_replica_zones" {
  description = "The replica zones for the regional persistent disk."
  type        = list(string)
}

variable "pv_name" {
  description = "The name of the PersistentVolume."
  type        = string
}

variable "pv_role" {
  description = "The role of the PersistentVolume (e.g., app-data, db-data)."
  type        = string
}
