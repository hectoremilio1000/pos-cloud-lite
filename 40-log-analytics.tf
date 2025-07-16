#/Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/40-log-analytics.tf
resource "azurerm_log_analytics_workspace" "logs" {
  name                = "pos-logs-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}