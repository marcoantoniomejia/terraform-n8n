# environments/dev/variables.tf

variable "gcp_project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the resources."
  type        = string
  default     = "us-central1"
}

variable "gcp_replica_zones" {
  description = "A list of two zones for regional disk replication."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b"]
}
