# Módulo de Terraform: Disco Persistente Zonal

## Descripción

Este módulo de Terraform provisiona un **Disco Persistente Zonal (`google_compute_disk`)** en Google Cloud Platform.

Un disco zonal está alojado en una única zona de GCP (ej. `us-central1-a`). Es la opción adecuada para ser utilizada por recursos que viven en esa misma zona, como una única Máquina Virtual (VM). No ofrece replicación automática fuera de su zona.

**Nota**: Para cargas de trabajo que requieren alta disponibilidad, como las que corren en clústeres de GKE regionales, se recomienda utilizar el módulo `regional_persistent_disk` en su lugar.

## Uso

```hcl
module "mi_disco_zonal" {
  source = "./modules/persistent_disk"

  project_id   = "mi-proyecto-gcp"
  disk_name    = "disco-para-mi-vm"
  zone         = "us-central1-a"
  disk_type    = "pd-ssd"
  disk_size_gb = 50
}
```

## Entradas (Inputs)

| Nombre         | Descripción                                               | Tipo     | Requerido |
| -------------- | --------------------------------------------------------- | -------- | :-------: |
| `project_id`   | El ID del proyecto de GCP donde se creará el disco.       | `string` |    Sí     |
| `disk_name`    | El nombre del disco persistente.                          | `string` |    Sí     |
| `zone`         | La zona de GCP donde se creará el disco.                  | `string` |    Sí     |
| `disk_type`    | El tipo de disco (ej. `pd-ssd`, `pd-standard`).           | `string` |    Sí     |
| `disk_size_gb` | El tamaño del disco en Gigabytes (GB).                    | `number` |    Sí     |

## Salidas (Outputs)

| Nombre      | Descripción                                                                    |
| ----------- | ------------------------------------------------------------------------------ |
| `name`      | El nombre del disco persistente creado.                                        |
| `self_link` | El `self_link` del disco, útil para referenciarlo en otras configuraciones (ej. Persistent Volumes de Kubernetes). |