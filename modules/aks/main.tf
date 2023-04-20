resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.subnet.name}-${var.name}"
  location            = var.rg.location
  resource_group_name = var.rg.name
  dns_prefix          = var.rg.name

  network_profile {
    network_plugin = "azure"
  }

  default_node_pool {
    name           = "default"
    node_count     = var.pool_size
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}
