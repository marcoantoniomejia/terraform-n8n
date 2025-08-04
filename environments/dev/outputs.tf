# environments/dev/outputs.tf

output "n8napp_disk_name_dev" {
  description = "Name of the regional persistent disk for n8n application data."
  value       = module.n8napp_disk_dev.name
}

output "psgdata_disk_name_dev" {
  description = "Name of the regional persistent disk for PostgreSQL data."
  value       = module.psgdata_disk_dev.name
}