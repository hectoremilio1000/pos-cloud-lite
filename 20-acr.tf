# /Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/20-acr.tf
resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_prefix}${random_id.suffix.hex}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"

  admin_enabled = true # ← antes era true
}
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
