# /Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/50-aca-env.tf
resource "azurerm_container_app_environment" "aca_env" {
  name                = "pos-env"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # descomenta para enviar logs a Log Analytics
  # log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
}
