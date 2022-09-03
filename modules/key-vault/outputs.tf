output "vault-id" {
  value = azurerm_key_vault.vault.id
}

output "key-id" {
  value = azurerm_key_vault_key.key.id
}
