# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\dev\outputs.tf

output "gke_cluster_name_dev" {
  description = "Name of the GKE cluster for the Dev environment."
  value       = module.gke_cluster.cluster_name
}
