# Módulo de Terraform: Disco Persistente Regional

## Descripción

Este módulo de Terraform provisiona un **Disco Persistente Regional (`google_compute_region_disk`)** en Google Cloud Platform.

A diferencia de un disco zonal, un disco regional replica los datos de forma sincrónica entre dos zonas dentro de una misma región (ej. entre `us-central1-a` y `us-central1-b`). Esta característica proporciona **alta disponibilidad** para el almacenamiento. Si una de las zonas falla, el disco puede ser adjuntado a una carga de trabajo en la otra zona de réplica, garantizando la continuidad del servicio.

Es la opción recomendada para cargas de trabajo críticas y con estado que se ejecutan en clústeres de GKE regionales.

## Uso

```hcl
module "mi_disco_regional" {
  source = "./modules/regional_persistent_disk"

  project_id    = "mi-proyecto-gcp"
  disk_name     = "disco-ha-para-mi-db"
  region        = "us-central1"
  replica_zones = ["us-central1-a", "us-central1-f"]
  disk_type     = "pd-ssd"
  disk_size_gb  = 100
}
```

## Entradas (Inputs)

| Nombre          | Descripción                                                                 | Tipo          | Requerido |
| --------------- | --------------------------------------------------------------------------- | ------------- | :-------: |
| `project_id`    | El ID del proyecto de GCP donde se creará el disco.                         | `string`      |    Sí     |
| `disk_name`     | El nombre del disco persistente regional.                                   | `string`      |    Sí     |
| `region`        | La región de GCP donde se creará el disco.                                  | `string`      |    Sí     |
| `replica_zones` | Una lista de dos zonas dentro de la región donde se replicará el disco.     | `list(string)`|    Sí     |
| `disk_type`     | El tipo de disco (ej. `pd-balanced`, `pd-ssd`).                             | `string`      |    Sí     |
| `disk_size_gb`  | El tamaño del disco en Gigabytes (GB).                                      | `number`      |    Sí     |

## Salidas (Outputs)

| Nombre      | Descripción                                                                    |
| ----------- | ------------------------------------------------------------------------------ |
| `name`      | El nombre del disco persistente regional creado.                               |
| `self_link` | El `self_link` del disco, útil para referenciarlo en otras configuraciones (ej. Persistent Volumes de Kubernetes). |