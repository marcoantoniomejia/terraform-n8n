# Módulo de Terraform: Disco Persistente Regional

## Descripción

Este módulo de Terraform provisiona un **Disco Persistente Regional (`google_compute_region_disk`)** en Google Cloud Platform.

A diferencia de un disco zonal, un disco regional replica los datos de forma sincrónica entre dos zonas dentro de una misma región (ej. entre `us-central1-a` y `us-central1-b`). Esta característica proporciona **alta disponibilidad** para el almacenamiento. Si una de las zonas falla, el disco puede ser adjuntado a una carga de trabajo en la otra zona de réplica, garantizando la continuidad del servicio.

El disco se crea con las etiquetas `managed-by = "terraform"` y `purpose = "<disk_name>"` para una mejor gestión y seguimiento de los recursos.

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

## Archivos del Módulo

- `main.tf`: Contiene la lógica principal del módulo, donde se define el recurso `google_compute_region_disk`.
- `variables.tf`: Define las variables de entrada que el módulo acepta. **No modifiques este archivo para cambiar valores**. Los valores de las variables deben pasarse desde la configuración del entorno que utiliza el módulo (ej. `environments/dev/main.tf`).
- `outputs.tf`: Define las variables de salida del módulo.
- `README.md`: Este archivo de documentación.
- `OWNERS`: Archivo que especifica los propietarios y responsables del módulo.

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