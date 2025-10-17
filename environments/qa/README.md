# Entorno de Pruebas (qa)

Este directorio contiene la configuración de Terraform para el entorno de pruebas.

## Cómo Desplegar

**IMPORTANTE:** Asegúrate de estar en el directorio correcto antes de ejecutar los siguientes comandos.

1.  **Navega al directorio del entorno.**
    ```bash
    # Desde la raíz del proyecto
    cd environments/qa
    ```

2.  **Inicializa Terraform.**
    La primera vez que trabajes en este entorno, o si cambias los módulos, necesitas inicializar Terraform. Esto conectará Terraform con el backend remoto correcto (definido en `backend.tf`).
    ```bash
    terraform init
    ```

3.  **Planifica los cambios.**
    Ejecuta `terraform plan` para ver los cambios que se aplicarán. Terraform cargará automáticamente las variables desde el archivo `terraform.tfvars`.
    ```bash
    terraform plan
    ```

4.  **Aplica los cambios.**
    Si el plan es correcto, aplica la configuración.
    ```bash
    terraform apply
    ```

## Variables de Entrada

Las variables para este entorno se gestionan exclusivamente en el archivo `terraform.tfvars` de este directorio.