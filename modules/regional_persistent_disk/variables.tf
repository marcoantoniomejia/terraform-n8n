# modules/regional_persistent_disk/variables.tf

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "disk_name" {
  description = "The name of the regional persistent disk."
  type        = string
}

variable "region" {
  description = "The GCP region where the disk will be created."
  type        = string
}

variable "replica_zones" {
  description = "The zones where the disk should be replicated to."
  type        = list(string)
}

variable "disk_type" {
  description = "The type of the disk (e.g., 'pd-balanced', 'pd-ssd')."
  type        = string
}

variable "disk_size_gb" {
  description = "The size of the disk in GB."
  type        = number
}