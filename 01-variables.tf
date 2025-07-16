# /Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/01-variables.tf
# 01-variables.tf
# ────────────────────────────────────────────────────────────
# Sufijo aleatorio para nombres únicos (ACR, Log Analytics…)
resource "random_id" "suffix" {
  byte_length = 3
}

variable "location" {
  type    = string
  default = "westus2"
}

variable "resource_group_name" {
  type    = string
  default = "pos-rg"
}

# Prefijo para el Container Registry.
# El sufijo aleatorio se concatena en 20-acr.tf.
variable "acr_prefix" {
  type    = string
  default = "posacr"
}

variable "pg_server" {
  type    = string
  default = "postgresflex"
}

variable "pg_password" {
  type = string
}

# Etiqueta por defecto para la imagen Docker;
# la sobreescribes con -var="image_tag=0.1.1" al hacer apply.
variable "image_tag" {
  type    = string
  default = "managed-by-github"
}
# ────────────────────────────────────────────────────────────
