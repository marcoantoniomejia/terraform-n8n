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
