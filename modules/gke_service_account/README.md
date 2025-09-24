# Módulo de Terraform: GKE Service Account

## Descripción

Este módulo de Terraform provisiona una **Cuenta de Servicio (Service Account)** de Google IAM diseñada específicamente para ser utilizada por los nodos de un clúster de GKE.

El módulo sigue el principio de menor privilegio al asignar únicamente los roles esenciales que los nodos de GKE necesitan para operar en el ecosistema de Google Cloud:
- **`roles/logging.logWriter`**: Permite a los nodos enviar logs a Cloud Logging.
- **`roles/monitoring.viewer`**: Permite a los nodos enviar métricas a Cloud Monitoring.
- **`roles/artifactregistry.reader`**: Permite a los nodos descargar imágenes de contenedor desde Artifact Registry, lo cual es crucial para los despliegues.

## Uso

Para utilizar este módulo, inclúyelo en tu código de la siguiente manera. La salida `email` de este módulo se puede pasar directamente a la variable `node_service_account_email` del módulo `gke_cluster`.

```hcl
module "gke_service_account" {
  source = "./modules/gke_service_account"

  project_id  = "mi-proyecto-gcp"
  name_prefix = "mi-app-dev"
}

module "gke_cluster" {
  source = "./modules/gke_cluster"
  
  # ... otras variables del clúster ...
  node_service_account_email = module.gke_service_account.email
}
```

## Entradas (Inputs)

| Nombre        | Descripción                                                    | Tipo     | Requerido |
| ------------- | -------------------------------------------------------------- | -------- | :-------: |
| `project_id`  | El ID del proyecto de GCP donde se creará la cuenta de servicio. | `string` |    Sí     |
| `name_prefix` | Un prefijo para el nombre de la cuenta de servicio (ej. `dev`). | `string` |    Sí     |

## Salidas (Outputs)

| Nombre  | Descripción                                                                 |
| ------- | --------------------------------------------------------------------------- |
| `email` | El email de la cuenta de servicio creada, lista para ser usada por los nodos de GKE. |