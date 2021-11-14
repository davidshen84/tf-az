output "id" {
  value = azuread_service_principal.sp.id
}

output "password" {
  sensitive = true
  value = azuread_service_principal_password.sp.value
}
