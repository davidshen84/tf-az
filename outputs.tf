# output "demo-1" {
#   value = module.aks-1.aks_get_credential
# }

# output "demo-2" {
#   value = module.aks-2.aks_get_credential
# }

output "container-name" {
  value = random_string.store_id.result
}

output "blob-access-key" {
  sensitive = true
  value = module.storage-container.access-key
}
