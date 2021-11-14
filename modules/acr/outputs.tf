output "server" {
  value = azurerm_container_registry.acr.login_server
}

output "admin" {
  value = azurerm_container_registry.acr.admin_username
}

output "id" {
  value = azurerm_container_registry.acr.id
}
