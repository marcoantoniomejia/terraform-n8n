# Módulo Terraform: Backend de GCS

Este módulo crea y configura un bucket de Google Cloud Storage (GCS) diseñado específicamente para ser utilizado como backend remoto para el estado de Terraform (`.tfstate`).

Implementa las siguientes mejores prácticas para un bucket de estado:
- **Nombre Único**: Genera un nombre de bucket único a nivel global para evitar conflictos.
- **Control de Versiones**: Habilita el control de versiones en el bucket para proteger contra la eliminación o corrupción accidental del archivo de estado.
- **Acceso Uniforme a Nivel de Bucket**: Simplifica la gestión de permisos.
- **Prevención de Eliminación**: Evita la destrucción accidental del bucket si no está vacío.

---

## Uso

```terraform
module "gcs_backend_bucket" {
  source = "./modules/gcs_backend"

  project_id = "your-gcp-project-id"
  location   = "us-central1"
}
```

---

## Entradas (Inputs)

| Nombre       | Descripción                                                  | Tipo     | Por Defecto | Requerido |
|--------------|--------------------------------------------------------------|----------|-------------|:---------:|
| `project_id` | El ID del proyecto de GCP donde se creará el bucket.         | `string` | `n/a`       |    sí     |
| `location`   | La ubicación (región, multirregión) para el bucket de GCS.   | `string` | `n/a`       |    sí     |

---

## Salidas (Outputs)

| Nombre        | Descripción                                        |
|---------------|----------------------------------------------------|
| `bucket_name` | El nombre único global del bucket de GCS creado.   |