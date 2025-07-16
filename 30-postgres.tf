#/Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/30-postgres.tf
resource "random_password" "pg_admin" {
  length  = 20
  special = true
}

resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "postgresflex-${random_id.suffix.hex}" # ← ahora es único
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  zone                   = "3" # ← mantiene la zona actual
  administrator_login    = "pgadmin"
  administrator_password = random_password.pg_admin.result
  sku_name               = "B_Standard_B1ms" # 1 vCPU / 2 GB
  storage_mb             = 32768             # 32 GB
  version                = "16"
  # firewall_rule ... (añade si necesitas acceso fuera de ACA)
}