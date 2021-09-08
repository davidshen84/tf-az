output "access-key" {
  value = azurerm_storage_account.account.primary_access_key
}

output "account_name" {
  value = azurerm_storage_account.account.name
}

output "container_name" {
  value = azurerm_storage_container.container.name
}
