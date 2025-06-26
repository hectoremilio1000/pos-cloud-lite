# 20-acr.tf  (CAMBIO PEQUEÑO)
resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_prefix}${random_id.suffix.hex}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"

  admin_enabled = false # ← antes era true
}
