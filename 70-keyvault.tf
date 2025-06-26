# 70-keyvault.tf ─ Key Vault + RBAC + secreto DB
resource "azurerm_key_vault" "kv" {
  name                = "pos-kv-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                      = "standard"
  enable_rbac_authorization     = true
  public_network_access_enabled = true
}

# Rol de datos para el Service Principal que ejecuta Terraform
resource "azurerm_role_assignment" "kv_sp_secret_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer" # o “Key Vault Administrator”
  principal_id         = data.azurerm_client_config.current.object_id
}

# Rol de solo-lectura para la Managed Identity del Container App
resource "azurerm_role_assignment" "kv_secrets" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.acr_pull.principal_id
}

# Secreto con la cadena de conexión
resource "azurerm_key_vault_secret" "db_url" {
  name         = "db-url"
  value        = "postgresql://pgadmin:${random_password.pg_admin.result}@${azurerm_postgresql_flexible_server.db.fqdn}/pos"
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_role_assignment.kv_sp_secret_officer] # asegura permisos antes de crear
}
