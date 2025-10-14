
output "instance_name" {
  description = "El nombre de la instancia del bastión."
  value       = google_compute_instance.bastion.name
}

output "internal_ip" {
  description = "La dirección IP interna del bastión."
  value       = google_compute_instance.bastion.network_interface[0].network_ip
}

output "external_ip" {
  description = "La dirección IP externa del bastión."
  value       = google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip
}
