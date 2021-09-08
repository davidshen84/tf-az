resource "azurerm_storage_account" "account" {
  name                     = var.account
  resource_group_name      = var.rg.name
  location                 = var.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = var.name
  storage_account_name  = azurerm_storage_account.account.name
  container_access_type = "private"
}
