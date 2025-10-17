# Módulo de Terraform: GCS Backend

## Descripción

Este módulo de Terraform provisiona un bucket en **Google Cloud Storage (GCS)** diseñado específicamente para ser utilizado como backend remoto para el estado de Terraform (`.tfstate`).

La configuración de este módulo sigue las mejores prácticas de seguridad para la gestión del estado, incluyendo:
- **Versionado de Objetos**: Habilitado para poder restaurar el estado a una versión anterior en caso de corrupción.
- **Prevención de Destrucción**: Activado para evitar la eliminación accidental del bucket, un error que podría causar la pérdida total del estado de la infraestructura.

## Uso

Este módulo se utiliza típicamente en una configuración inicial o "bootstrap" para crear el bucket que luego será consumido por otros entornos.

```hcl
module "gcs_backend_bucket" {
  source = "./modules/gcs_backend"

  project_id = "tu-proyecto-gcp-admin"
  location   = "us-central1"
  bucket_name_prefix = "tfstate-mi-app"
}
```

Después de ejecutar esto, puedes configurar el backend en otros proyectos de la siguiente manera:

```hcl
terraform {
  backend "gcs" {
    bucket = "tfstate-mi-app-tu-proyecto-gcp-admin"
    prefix = "dev"
  }
}
```

## Archivos del Módulo

- `main.tf`: Contiene la lógica principal del módulo, donde se define el recurso `google_storage_bucket`.
- `variables.tf`: Define las variables de entrada que el módulo acepta. **No modifiques este archivo para cambiar valores**. Los valores de las variables deben pasarse desde la configuración del entorno que utiliza el módulo (ej. `bootstrap/main.tf`).
- `outputs.tf`: Define las variables de salida del módulo.
- `README.md`: Este archivo de documentación.
- `OWNERS`: Archivo que especifica los propietarios y responsables del módulo.

## Entradas (Inputs)

| Nombre               | Descripción                                                                                             | Tipo     | Por Defecto     | Requerido |
| -------------------- | ------------------------------------------------------------------------------------------------------- | -------- | --------------- | :-------: |
| `project_id`         | El ID del proyecto de GCP donde se creará el bucket.                                                    | `string` |                 |    Sí     |
| `location`           | La ubicación para el bucket. Puede ser una multiregión (`US`) o una región (`us-central1`).             | `string` | `"US-CENTRAL1"` |    No     |
| `bucket_name_prefix` | Prefijo para el nombre del bucket. El nombre final será `<prefix>-<project_id>`.                        | `string` | `"tfstate"`     |    No     |

## Salidas (Outputs)

| Nombre        | Descripción                                                              |
| ------------- | ------------------------------------------------------------------------ |
| `bucket_name` | El nombre completo del bucket de GCS creado, listo para usar en la configuración del backend. |
