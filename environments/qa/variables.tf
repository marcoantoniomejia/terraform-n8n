# environments/qa/variables.tf

variable "gcp_project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the resources."
  type        = string
  default     = "us-central1"
}

variable "gcp_node_locations" {
  description = "A list of zones for the regional GKE cluster nodes."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c"]
}