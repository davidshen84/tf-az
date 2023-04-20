resource "azuread_service_principal" "sp" {
  application_id               = var.app.application_id
  app_role_assignment_required = false
  owners                       = var.owners
}

resource "azuread_service_principal_password" "spp" {
  service_principal_id = azuread_service_principal.sp.object_id
}
