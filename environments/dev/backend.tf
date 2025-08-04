# c:\Users\marmejia\Documents\Desarrollo\terraform-n8n\terraform-n8n\environments\dev\backend.tf

terraform {
  backend "gcs" {
    # Este nombre de bucket debe ser el que se genera en el paso de 'bootstrap'.
    # Ejemplo: "tfstate-gcp-project-12345"
    bucket = "NOMBRE_DEL_BUCKET_DE_TFSTATE"
    # El prefijo organiza los tfstate de cada entorno en "carpetas" dentro del bucket.
    prefix = "dev"
  }
}