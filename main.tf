terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.20.0"
    }
  }

  required_version = ">= 1.2.7"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azuread_client_config" "current" {}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "default" {
  name     = "default"
  location = "Australia East"
}

resource "azuread_application" "default" {
  display_name = "default"
  owners       = [data.azuread_client_config.current.object_id]
}

# module "aks-1" {
#   source = "./modules/aks"

#   prefix = "demo-1"
#   location = var.resource_location
#   cluster_name = "demo-1"
#   pool_size = 3
#   vm_size = var.aks_vm_size
# }

# module "aks-2" {
#   source = "./modules/aks"

#   prefix = "demo-2"
#   location = "australiaeast"
#   cluster_name = "demo-2"
#   pool_size = 2
#   vm_size = var.aks_vm_size
# }

resource "random_string" "rndstr" {
  keepers = {
    rg = azurerm_resource_group.default.name
  }

  length  = 7
  lower   = true
  upper   = false
  special = false
  numeric = true
}

# module "storage_container" {
#   source = "./modules/storage"

#   account = random_string.store_id.result
#   name = "blob"
#   rg = azurerm_resource_group.default
# }

# resource "azurerm_storage_blob" "test_blob" {
#   name = "a-blob"
#   storage_account_name = random_string.store_id.result
#   storage_container_name = "blob"
#   type = "Block"
#   source = "./README.md"
# }

# module "storage_container_2" {
#   source = "./modules/storage"

#   account = random_string.store_id_2.result
#   name = "blob"
#   rg = azurerm_resource_group.default
# }

# module "mssql" {
#   source = "./modules/mssql"

#   rg = azurerm_resource_group.default
#   server_name = "mssql-toy1"
#   database_name = "toydb1"
#   admin_name = "toyadmin"
#   admin_password = "admin!Passw0rd"
#   sku_name = "GP_Gen5_2"
# }

# module "appi" {
#   source = "./modules/appinsights"

#   rg = azurerm_resource_group.default
#   name = "appi-1"
#   location = var.resource_location
# }

# module "acr" {
#   source = "./modules/acr"

#   rg   = azurerm_resource_group.default
#   name = "acr${random_string.rndstr.result}"
#   # location = null
# }

module "sp" {
  source = "./modules/sp"
  app    = azuread_application.default
  owners = [data.azuread_client_config.current.object_id]
}

# resource "azurerm_role_assignment" "acr-contributer" {
#   scope                = module.acr.id
#   role_definition_name = "Contributor"
#   principal_id         = module.sp.id
# }

# module "mongodb" {
#   source = "./modules/cosmos_mongo"

#   rg           = azurerm_resource_group.default
#   account_name = random_string.rndstr.result
# }

module "key-vault" {
  source    = "./modules/key-vault"
  rg        = azurerm_resource_group.default
  tenant_id = data.azurerm_client_config.current.tenant_id
  owner_id  = data.azuread_client_config.current.object_id
}

resource "azurerm_key_vault_access_policy" "kv-sp" {
  key_vault_id = module.key-vault.vault-id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.sp.id

  key_permissions = [
    "Get",
    "List",
    "Encrypt",
    "Decrypt"
  ]
}
