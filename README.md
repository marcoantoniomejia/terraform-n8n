# Infraestructura de n8n en GCP con Terraform

Este proyecto contiene el código de Terraform para desplegar la infraestructura necesaria para una instancia de n8n sobre un clúster de Google Kubernetes Engine (GKE).

## Estructura de Directorios

El repositorio está organizado en módulos y entornos:

-   `modules/`: Contiene los módulos de Terraform reutilizables (ej. `gke`, `network`). Cada módulo define un conjunto de recursos relacionados.
-   `environments/`: Contiene las configuraciones para cada entorno de despliegue (`dev`, `prod`, etc.). Desde aquí se ejecutan los comandos de Terraform.

terraform-n8n/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       └── backend.tf
│
├── modules/
│   ├── gke/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── persistent_disk/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│   └── regional_persistent_disk/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── .gitignore
└── README.md



## Prerrequisitos

1.  Terraform instalado.
2.  Google Cloud SDK instalado y configurado.
3.  Autenticación con GCP: `gcloud auth application-default login`.
4.  Un bucket de GCS para almacenar el estado de Terraform (tfstate).

## Cómo Desplegar (Ejemplo para el entorno `dev`)

1.  Navega al directorio del entorno:
    ```sh
    cd environments/dev
    ```
2.  Inicializa Terraform. Esto descargará los proveedores y configurará el backend.
    ```sh
    terraform init
    ```
3.  Crea un archivo `terraform.tfvars` con los valores para tu proyecto (puedes usar `terraform.tfvars.example` como plantilla si lo creas).

4.  Planifica los cambios para ver qué se creará/modificará:
    ```sh
    terraform plan
    ```

5.  Aplica los cambios para crear la infraestructura:
    ```sh
    terraform apply
    ```