# Módulo de Terraform: Red VPC

## Descripción

Este módulo de Terraform está destinado a provisionar la infraestructura de red en **Google Cloud Platform**.

**ESTE MÓDULO NO ESTÁ IMPLEMENTADO ACTUALMENTE.**

Cuando se implemente, este módulo se encargará de crear y gestionar los siguientes recursos:
- Una **Red VPC (`google_compute_network`)**: La red principal que aislará los recursos.
- **Subredes (`google_compute_subnetwork`)**: Segmentos de la VPC para organizar recursos, como los nodos de GKE y las instancias de bases de datos.
- **Reglas de Firewall (`google_compute_firewall`)**: Para controlar el tráfico entre subredes y desde/hacia internet.

## Uso

Actualmente, el módulo no tiene funcionalidad. Una vez implementado, se podría usar de la siguiente manera:

```hcl
# Ejemplo de uso futuro
module "network" {
  source = "./modules/network"

  project_id   = "mi-proyecto-gcp"
  network_name = "mi-vpc"
  # ... otras variables ...
}
```

## Archivos del Módulo

- `main.tf`: Contiene la lógica principal del módulo. Actualmente está vacío.
- `variables.tf`: Define las variables de entrada que el módulo acepta. Actualmente está vacío.
- `outputs.tf`: Define las variables de salida del módulo. Actualmente está vacío.
- `README.md`: Este archivo de documentación.
- `OWNERS`: Archivo que especifica los propietarios y responsables del módulo.

## Entradas (Inputs)

*No hay variables de entrada definidas actualmente.*

## Salidas (Outputs)

*No hay variables de salida definidas actualmente.*
