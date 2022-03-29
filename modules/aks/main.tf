variable "rg" {
  description = "the resource group object"
}

variable "pool_size" {
  description = "aks managed pool size"
}

variable "vm_size" {
  description = "aks vm size"
}

variable "subnet_id" {
  description = "vnet subnet id"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.rg.name}-aks"
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_prefix          = var.rg.name

  default_node_pool {
    name           = "default"
    node_count     = var.pool_size
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_get_credential" {
  value = "az aks get-credentials --name ${azurerm_kubernetes_cluster.aks.name} --resource ${var.rg.name}"
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
