# Módulo de Terraform: Artifact Registry

## Descripción

Este módulo de Terraform se encarga de provisionar un repositorio de tipo Docker en **Google Artifact Registry**. Es la solución recomendada para almacenar y gestionar las imágenes de contenedor utilizadas por las aplicaciones en GCP.

El módulo crea un único recurso `google_artifact_registry_repository` con el formato `DOCKER`.

## Uso

Para utilizar este módulo, inclúyelo en tu código de Terraform de la siguiente manera:

```hcl
module "artifact_registry" {
  source = "./modules/artifact_registry"

  project_id      = "tu-proyecto-gcp"
  location        = "us-central1"
  repository_name = "mi-repo-de-aplicaciones"
}
```

## Entradas (Inputs)

| Nombre            | Descripción                                    | Tipo   | Requerido |
| ----------------- | ---------------------------------------------- | ------ | :-------: |
| `project_id`      | El ID del proyecto de GCP.                     | `string` |    Sí     |
| `location`        | La ubicación (región) de GCP para el repositorio. | `string` |    Sí     |
| `repository_name` | El nombre para el repositorio de Artifact Registry. | `string` |    Sí     |

## Salidas (Outputs)

| Nombre           | Descripción                                      |
| ---------------- | ------------------------------------------------ |
| `repository_url` | La URL completa del repositorio de Artifact Registry, lista para usar en comandos `docker push/pull`. |
| `repository_id`  | El ID del repositorio de Artifact Registry creado. |