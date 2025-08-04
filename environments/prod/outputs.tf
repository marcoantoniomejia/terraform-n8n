# environments/prod/outputs.tf

output "n8napp_disk_name" {
  description = "Name of the persistent disk for n8n application data."
  value       = module.n8napp_disk.name
}

output "psgdata_disk_name" {
  description = "Name of the persistent disk for PostgreSQL data."
  value       = module.psgdata_disk.name
}