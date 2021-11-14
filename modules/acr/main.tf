variable "rg" {
  description = "resource group object"
}

variable "name" {
  description = "ACR name"
}

# variable "location" {
#   description = "ACR geo-location"
# }

variable "sku" {
  description = "Basic, Standard or Premium level"
  default = "Basic"
}

resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.rg.name
  location            = var.rg.location
  sku                 = var.sku
  admin_enabled       = false
}

output "server" {
  value = azurerm_container_registry.acr.login_server
}

output "admin" {
  value = azurerm_container_registry.acr.admin_username
}
