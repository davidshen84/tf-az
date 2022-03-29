variable "rg" {
  description = "resource group object"
}

variable "sku" {
  description = "Basic, Standard or Premium level"
  default     = "Basic"
}

locals {
  premium_network = var.sku == "Premium" ? [1] : []
}

resource "random_string" "acr" {
  keepers = {
    rg = var.rg.id
  }

  length  = 13
  lower   = true
  upper   = false
  special = false
  number  = true
}

resource "azurerm_container_registry" "acr" {
  name                = random_string.acr.result
  resource_group_name = var.rg.name
  location            = var.rg.location
  sku                 = var.sku
  admin_enabled       = false

  public_network_access_enabled = false

  dynamic "network_rule" {
    for_each = locals.premium_network
    content {
      network_rule_set {
        default_action = "Deny"
      }
    }
  }
}

output "server" {
  value = azurerm_container_registry.acr.login_server
}

output "admin" {
  value = azurerm_container_registry.acr.admin_username
}

output "id" {
  value = azurerm_container_registry.acr.id
}
