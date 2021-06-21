resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-${var.cluster_name}"
  location            = "${var.rg.location}"
  resource_group_name = "${var.rg.name}"
  dns_prefix          = "${var.prefix}-${var.cluster_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = var.pool_size
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}
