terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.58.0"
    }
  }

  required_version = ">= 0.14.9"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "q-resources"
  location = "Australia East"
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

resource "random_string" "store_id" {
  keepers = {
    rg = azurerm_resource_group.main.name
  }

  length = 24
  lower = true
  upper = false
  special = false
  number = true
}

module "storage-container" {
  source = "./modules/storage"

  name = "${random_string.store_id.result}"
  container_name = "blobs"
  rg = azurerm_resource_group.main
}
