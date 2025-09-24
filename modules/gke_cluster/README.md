# Módulo de Terraform: Google Kubernetes Engine (GKE)

## Descripción

Este módulo de Terraform provisiona un clúster de **Google Kubernetes Engine (GKE)** con una configuración robusta y personalizable. Está diseñado para soportar escenarios comunes y avanzados, como clústeres privados y conectividad con VPC Compartida (Shared VPC).

El módulo crea un clúster de GKE y un pool de nodos primario con las siguientes características clave:
- **Integración con Shared VPC**: Permite que el clúster se conecte a una red VPC que reside en un proyecto Host diferente.
- **Clúster Privado**: Capacidad de configurar el clúster con nodos y/o endpoint principal privados para mayor seguridad.
- **Pool de Nodos Configurable**: Permite definir el tipo de máquina, tamaño de disco y zonas.
- **Auto-escalado**: Soporte para escalar automáticamente el número de nodos según la carga de trabajo.
- **Cuenta de Servicio Personalizada**: Asigna una cuenta de servicio de IAM específica a los nodos para seguir el principio de menor privilegio.

## Uso

A continuación se muestra un ejemplo de cómo utilizar el módulo para crear un clúster de GKE privado en una Shared VPC.

```hcl
module "gke_cluster" {
  source = "./modules/gke_cluster"

  # --- Identificadores ---
  name_prefix = "mi-app-dev"
  project_id  = "mi-proyecto-de-servicio"
  region      = "us-central1"

  # --- Red (Shared VPC) ---
  network_project_id = "mi-proyecto-host-vpc"
  network_name       = "vpc-compartida"
  subnetwork_name    = "subred-para-nodos"

  # --- Clúster Privado ---
  private_cluster_config = {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.32/28"
  }

  # --- Pool de Nodos ---
  node_locations             = ["us-central1-a", "us-central1-b"]
  machine_type               = "e2-medium"
  node_service_account_email = "gke-sa@mi-proyecto-de-servicio.iam.gserviceaccount.com"
  
  # --- Auto-escalado ---
  enable_autoscaling = true
  min_node_count     = 1
  max_node_count     = 5
}
```

## Entradas (Inputs)

### Configuración General

| Nombre                 | Descripción                                                                                   | Tipo     | Por Defecto                                | Requerido |
| ---------------------- | --------------------------------------------------------------------------------------------- | -------- | ------------------------------------------ | :-------: |
| `name_prefix`          | Un prefijo que se añadirá al nombre de todos los recursos creados.                            | `string` |                                            |    Sí     |
| `project_id`           | El ID del proyecto de GCP donde se creará el clúster.                                         | `string` |                                            |    Sí     |
| `region`               | La región de GCP donde se desplegará el clúster.                                              | `string` |                                            |    Sí     |
| `logging_service`      | El servicio de logging a utilizar.                                                            | `string` | `"logging.googleapis.com/kubernetes"`      |    No     |
| `monitoring_service`   | El servicio de monitoreo a utilizar.                                                          | `string` | `"monitoring.googleapis.com/kubernetes"`   |    No     |

### Configuración de Red

| Nombre                 | Descripción                                                                                             | Tipo     | Por Defecto | Requerido |
| ---------------------- | ------------------------------------------------------------------------------------------------------- | -------- | ----------- | :-------: |
| `network_name`         | El nombre de la red VPC a la que se conectará el clúster.                                               | `string` |             |    Sí     |
| `subnetwork_name`      | El nombre de la subred para los nodos del clúster.                                                      | `string` |             |    Sí     |
| `network_project_id`   | El ID del proyecto Host de la VPC compartida. Si es nulo, se asume que la red está en el mismo proyecto. | `string` | `null`      |    No     |
| `private_cluster_config` | Objeto de configuración para un clúster privado. Si es nulo, el clúster será público.                  | `object` | `null`      |    No     |

### Configuración del Pool de Nodos

| Nombre                       | Descripción                                                                                             | Tipo          | Por Defecto       | Requerido |
| ---------------------------- | ------------------------------------------------------------------------------------------------------- | ------------- | ----------------- | :-------: |
| `initial_node_count`         | El número inicial de nodos para el clúster.                                                             | `number`      | `2`               |    No     |
| `machine_type`               | El tipo de máquina para los nodos.                                                                      | `string`      | `"e2-standard-2"` |    No     |
| `disk_size_gb`               | Tamaño del disco de arranque de los nodos en GB.                                                        | `number`      | `30`              |    No     |
| `disk_type`                  | Tipo de disco de arranque (`pd-standard` o `pd-ssd`).                                                   | `string`      | `"pd-standard"`   |    No     |
| `node_locations`             | Lista de zonas donde se crearán los nodos (para clústeres regionales).                                  | `list(string)`| `null`            |    No     |
| `node_service_account_email` | El email de la cuenta de servicio para los nodos. Si es nulo, se usa la cuenta por defecto de Compute. | `string`      | `null`            |    No     |

### Configuración de Auto-escalado

| Nombre                 | Descripción                                                    | Tipo     | Por Defecto | Requerido |
| ---------------------- | -------------------------------------------------------------- | -------- | ----------- | :-------: |
| `enable_autoscaling`   | Si es `true`, habilita el auto-escalado para el pool de nodos. | `bool`   | `false`     |    No     |
| `min_node_count`       | Número mínimo de nodos para el auto-escalado.                  | `number` | `1`         |    No     |
| `max_node_count`       | Número máximo de nodos para el auto-escalado.                  | `number` | `3`         |    No     |

## Salidas (Outputs)

| Nombre             | Descripción                             |
| ------------------ | --------------------------------------- |
| `cluster_name`     | El nombre del clúster de GKE creado.    |
| `cluster_endpoint` | El endpoint del plano de control del clúster. |