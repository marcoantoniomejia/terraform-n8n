# modules/persistent_disk/variables.tf

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "disk_name" {
  description = "The name of the persistent disk."
  type        = string
}

variable "zone" {
  description = "The GCP zone where the disk will be created."
  type        = string
}

variable "disk_type" {
  description = "The type of the disk (e.g., 'pd-ssd', 'pd-standard')."
  type        = string
}

variable "disk_size_gb" {
  description = "The size of the disk in GB."
  type        = number
}