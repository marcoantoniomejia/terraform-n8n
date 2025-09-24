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
- `modules/`: Contiene los módulos reutilizables de Terraform para GKE, discos, etc. Cada módulo incluye su propio archivo `README.md` que detalla su funcionamiento, variables de entrada y salidas.

## Mejoras Recientes y Refactorización (Septiembre 2025)

Este proyecto ha sido recientemente refactorizado para alinearse con mejores prácticas de IaC (Infraestructura como Código) y para mejorar su mantenibilidad y claridad. Los cambios clave incluyen:

- **Modularización y Reutilización**: Se ha refactorizado la creación de discos persistentes en los entornos. En lugar de definir recursos `google_compute_region_disk` directamente, ahora se utiliza el módulo `regional_persistent_disk` con un bucle `for_each`. Esto reduce drásticamente la duplicación de código y centraliza la lógica de creación de discos.

- **Estandarización de Nomenclatura**: Se han renombrado las variables relacionadas con el tamaño de los discos para incluir el sufijo `_gb` (ej. `app_disk_size_gb`). Esto asegura una convención de nomenclatura consistente en todo el proyecto, como se define en las directrices internas.

- **Propiedad del Código (`OWNERS`)**: Se ha añadido un archivo `OWNERS` a cada módulo dentro del directorio `modules/`. Esto clarifica quién es el responsable del mantenimiento de cada componente de la infraestructura.

- **Documentación y Comentarios**:
    - Cada módulo ahora contiene un bloque de comentarios en español al inicio de su archivo `main.tf`, explicando su propósito, su caso de uso y su lógica principal.
    - El módulo `network` ha sido identificado como un placeholder y, aunque está vacío, se ha documentado su propósito esperado.

- **Configuración Explícita**: El archivo `terraform.tfvars` del entorno de desarrollo ha sido poblado con todas las variables requeridas, sirviendo como una plantilla clara para la configuración de nuevos entornos.

---

## Primeros Pasos (Usando Google Cloud Shell)

Se recomienda encarecidamente utilizar **Google Cloud Shell** para ejecutar este código, ya que viene con Terraform, `gcloud` y otras herramientas necesarias preinstaladas y configuradas.

1.  **Abrir Cloud Shell**: En la consola de Google Cloud, haz clic en el icono `>_` "Activar Cloud Shell" en la parte superior derecha.

2.  **Clonar el Repositorio**: Ejecuta el siguiente comando en tu terminal de Cloud Shell para clonar este proyecto:
    ```sh
    git clone https://github.com/marcoantoniomejia/terraform-n8n.git
    ```

3.  **Navegar al Directorio del Proyecto**:
    ```sh
    cd terraform-n8n
    ```

4.  **Permisos**: La cuenta de usuario con la que estás autenticado en Cloud Shell debe tener los permisos necesarios en los proyectos de GCP (tanto en el proyecto Host de la VPC como en los proyectos de servicio de cada entorno).

---

## Paso 0: Configuración de Variables

Antes de desplegar, debes configurar las variables específicas de tu entorno. Puedes usar el editor de código integrado de Cloud Shell (`code .`) para modificar los archivos desde la terminal.

1.  **ID del Proyecto Host de la VPC**: En los archivos `bootstrap/dev.tfvars`, `bootstrap/qa.tfvars` y `bootstrap/prd.tfvars`, reemplaza el valor de `gke_network_project_id` de `"tu-gcp-host-project-id-aqui"` por el ID real de tu proyecto Host de la VPC.

2.  **Subred del Plano de Control de GKE**: Google Cloud **exige** que la subred para el plano de control de un clúster privado de GKE tenga un tamaño de `/28`. Asegúrate de que las subredes `subnet-trans-n8n-dev-02`, `subnet-trans-n8n-qas-02` y `subnet-trans-n8n-prd-02` cumplen este requisito.

---

## Proceso de Despliegue (Desde Cloud Shell)

El despliegue de cada ambiente se realiza de forma independiente, navegando al directorio correspondiente.

**IMPORTANTE sobre Workspaces:** Este proyecto está diseñado para usar **directorios por ambiente**, no workspaces de Terraform. Cada ambiente (`dev`, `qa`, `prod`) tiene su propio backend configurado, lo que garantiza el aislamiento de su estado. **No es necesario usar `terraform workspace new`**. Asegúrate siempre de estar en el workspace `default` para evitar conflictos.

```bash
# (Opcional pero recomendado) Verifica que estás en el workspace default
terraform workspace select default
```

---

### Despliegue de un Ambiente (Ejemplo con `prod`)

Sigue estos pasos para desplegar o actualizar cualquier ambiente. Usaremos `prod` como ejemplo.

1.  **Navega al directorio del ambiente.**
    ```bash
    # Desde la raíz del proyecto
    cd environments/prod
    ```

2.  **Inicializa Terraform.**
    La primera vez que trabajes en un ambiente, o si cambias los módulos, necesitas inicializar Terraform. Esto conectará Terraform con el backend remoto correcto (definido en `backend.tf`).
    ```bash
    terraform init
    ```

3.  **Planifica los cambios.**
    Ejecuta `terraform plan` para ver los cambios que se aplicarán. Usamos el flag `-var-file` para cargar las variables correctas desde la carpeta `bootstrap`.
    ```bash
    terraform plan -var-file="../../bootstrap/prd.tfvars"
    ```

4.  **Aplica los cambios.**
    Si el plan es correcto, aplica la configuración.
    ```bash
    terraform apply -var-file="../../bootstrap/prd.tfvars"
    ```

**Para trabajar con `dev` o `qa`**, simplemente reemplaza `prod` por `dev` o `qa` en la ruta del directorio y en el nombre del archivo `.tfvars`.