# 10-mi.tf
resource "azurerm_user_assigned_identity" "acr_pull" {
  name                = "pos-acr-pull-mi"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
