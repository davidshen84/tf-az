# output "demo-1" {
#   value = module.aks-1.aks_get_credential
# }

# output "demo-2" {
#   value = module.aks-2.aks_get_credential
# }

# output "account-name" {
#   value = module.storage_container.account_name
# }

# output "account-name-2" {
#   value = module.storage_container_2.account_name
# }

# output "blob-access-key" {
#   sensitive = true
#   value = module.storage_container.access-key
# }

# output "appi-key" {
#   sensitive = true
#   value = module.appi.instrumentation_key
# }

# output "acr-server" {
#   value = module.acr.server
# }

# output "app-client-id" {
#   value = azuread_application.main.application_id
# }

output "sp-id" {
  value = module.sp.id
}

output "sp-password" {
  sensitive = true
  value = module.sp.password
}

# output "cosmos-mongodb-connection-strings" {
#   sensitive = true
#   value     = module.mongodb.connection_strings
# }

output "key-id" {
  value = module.key-vault.key-id
}
