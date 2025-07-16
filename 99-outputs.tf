#/Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/99-outputs.tf
output "pos_url" {
  value       = azurerm_container_app.pos.latest_revision_fqdn
  description = "URL pública del micro-servicio POS"
}
