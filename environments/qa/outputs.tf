# environments/qa/outputs.tf

output "gke_cluster_name_qa" {
  description = "Name of the GKE cluster for the QA environment."
  value       = module.gke_cluster.cluster_name
}