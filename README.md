# Despliegue de Infraestructura n8n con Terraform en GCP

Este proyecto utiliza Terraform para gestionar la infraestructura de la aplicación n8n en Google Cloud Platform, con una separación clara entre tres entornos: **Desarrollo (dev)**, **Pruebas (qa)** y **Producción (prd)**.

La infraestructura de cada entorno, gestionada a través de módulos de Terraform, incluye:
- Un clúster de Google Kubernetes Engine (GKE) configurado para usar una VPC Compartida.
- Un repositorio en Artifact Registry.
- Discos Persistentes para almacenamiento.
- Activación de APIs de Logging y Monitoring.

## Estructura del Proyecto

- `bootstrap/`: Contiene la configuración para crear el bucket de GCS que almacenará el estado de Terraform (`.tfstate`) para cada entorno.
- `environments/`: Contiene la configuración de la infraestructura principal para cada entorno (`dev`, `qa`, `prd`).
- `modules/`: (No mostrado) Contiene los módulos reutilizables de Terraform para GKE, discos, etc.

---

## Requisitos Previos

1.  **Terraform CLI**: Asegúrate de tener Terraform instalado (Descargar aquí).
2.  **Google Cloud SDK**: Instala y configura `gcloud` (Instrucciones aquí).
3.  **Autenticación**: Autentícate en GCP. El método más sencillo para un entorno local es:
    ```sh
    gcloud auth application-default login
    ```
4.  **Permisos**: La cuenta o usuario que ejecute Terraform debe tener los permisos necesarios en los proyectos de GCP (tanto en el proyecto Host de la VPC como en los proyectos de servicio de cada entorno).

---

## Paso 0: Configuración Inicial Obligatoria

Antes de desplegar, debes configurar las variables específicas de tu entorno.

1.  **ID del Proyecto Host de la VPC**: En los archivos `bootstrap/dev.tfvars`, `bootstrap/qa.tfvars` y `bootstrap/prd.tfvars`, reemplaza el valor de `gke_network_project_id` de `"tu-gcp-host-project-id-aqui"` por el ID real de tu proyecto Host de la VPC.

2.  **Subred del Plano de Control de GKE**: Google Cloud **exige** que la subred para el plano de control de un clúster privado de GKE tenga un tamaño de `/28`. Asegúrate de que las subredes `subnet-trans-n8n-dev-02`, `subnet-trans-n8n-qas-02` y `subnet-trans-n8n-prd-02` cumplen este requisito.

---

## Proceso de Despliegue

El despliegue se realiza en dos fases principales para cada entorno:
1.  **Bootstrap**: Crear el backend para el estado de Terraform.
2.  **Despliegue del Entorno**: Crear la infraestructura de la aplicación (GKE, discos, etc.).

### Fase 1: Creación del Backend (Bootstrap)

Este paso se ejecuta una vez por entorno para crear el bucket de GCS que guardará el estado.

```sh
# Navega al directorio de bootstrap
cd bootstrap

# Inicializa Terraform para este directorio
terraform init
```

**Para crear el backend de Desarrollo (dev):**
```sh
terraform apply -var-file="dev.tfvars"
```

**Para crear el backend de Pruebas (qa):**
```sh
terraform apply -var-file="qa.tfvars"
```

**Para crear el backend de Producción (prd):**
```sh
terraform apply -var-file="prd.tfvars"
```

> **Nota**: Cada `apply` te mostrará como salida el nombre del bucket de GCS que se ha creado. Necesitarás este nombre para el siguiente paso. El nombre suele seguir el patrón `gcs-tfstate-<project_id>`.

### Fase 2: Despliegue de la Infraestructura

Ahora desplegaremos los recursos de cada entorno, en el orden solicitado.

#### Despliegue de Desarrollo (dev)

1.  Navega al directorio del entorno de desarrollo.
    ```sh
    # Desde la raíz del proyecto
    cd environments/dev
    ```
2.  Inicializa Terraform, conectándolo con el backend remoto que creaste. **Reemplaza `<NOMBRE_DEL_BUCKET_DEV>`** con el nombre del bucket obtenido en la fase de bootstrap.
    ```sh
    terraform init -backend-config="bucket=gcs-tfstate-psa-td-corp-transf-n8n-dev"
    ```
3.  Planifica y aplica los cambios usando el archivo de variables de `dev`.
    ```sh
    terraform plan -var-file="../../bootstrap/dev.tfvars"
    terraform apply -var-file="../../bootstrap/dev.tfvars"
    ```

#### Despliegue de Pruebas (qa)

Repite el proceso para QA, usando sus propios archivos y bucket.
```sh
# Desde la raíz del proyecto
cd environments/qa

terraform init -backend-config="bucket=gcs-tfstate-psa-td-corp-transf-n8n-qa"
terraform apply -var-file="../../bootstrap/qa.tfvars"
```

#### Despliegue de Producción (prd)

Finalmente, repite el proceso para Producción. **Ten especial cuidado al aplicar cambios en este entorno.**
```sh
# Desde la raíz del proyecto
cd environments/prd

terraform init -backend-config="bucket=gcs-tfstate-psa-td-corp-transf-n8n-prd"
terraform apply -var-file="../../bootstrap/prd.tfvars"
```