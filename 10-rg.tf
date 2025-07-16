#/Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/10-rg.tf
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}