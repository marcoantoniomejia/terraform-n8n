# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\prd\outputs.tf

output "gke_cluster_name_prd" {
  description = "Name of the GKE cluster for the Production environment."
  value       = module.gke_cluster.cluster_name
}
