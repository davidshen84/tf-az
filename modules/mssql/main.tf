resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.rg.name
  location                     = var.rg.location
  version                      = "12.0"
  administrator_login          = var.admin_name
  administrator_login_password = var.admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "database" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = var.sku_name
  zone_redundant = false
}

resource "azurerm_mssql_firewall_rule" "AllowAzureIps" {
  name             = "AllowAzureIps"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
