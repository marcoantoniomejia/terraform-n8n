
resource "google_compute_instance" "bastion" {
  project      = var.project_id
  zone         = var.zone
  name         = var.instance_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    # La IP externa es necesaria para la configuración inicial.
    # Se puede restringir el acceso a través de reglas de firewall.
    access_config {}
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Actualizar paquetes e instalar herramientas básicas
    apt-get update
    apt-get install -y apt-transport-https ca-certificates gnupg curl

    # Instalar Google Cloud SDK
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    apt-get update && apt-get install -y google-cloud-sdk

    # Instalar kubectl
    apt-get install -y kubectl
  EOT

  tags = ["bastion-host"]
}
