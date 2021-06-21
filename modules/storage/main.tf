variable "name" {
  description = "storage name"
}

variable "container_name" {
  description = "container name"
}

variable "rg" {
  description = "resource group object"
}

variable "tags" {
  description = "resource tags object"
  default = {}
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.name
  resource_group_name      = var.rg.name
  location                 = var.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

output "access-key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}
