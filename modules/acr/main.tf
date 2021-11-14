resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.rg.name
  location            = var.rg.location
  sku                 = var.sku
  admin_enabled       = false
}
