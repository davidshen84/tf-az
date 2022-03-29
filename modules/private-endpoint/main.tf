variable "rg" {
  description = "resource group object"
}

variable "vnet_id" {
  description = "virtual network id"
}

variable "subnet_id" {
  description = "subnet id"
}

variable "resource_id" {
  description = "private connection resource id"
}

variable "subresources" {
  description = "a list of subresource names"
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns-vnet" {
  name                  = "${var.rg.name}-dns-vnet"
  resource_group_name   = var.rg.name
  virtual_network_id    = var.vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${var.rg.name}-endpoint"
  resource_group_name = var.rg.name
  location            = var.rg.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.rg.name}-service-connection"
    private_connection_resource_id = var.resource_id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "${var.rg.name}-dns-zones"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.dns.id
    ]
  }
}
