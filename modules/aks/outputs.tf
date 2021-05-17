output "aks_get_credential" {
  value = "az aks get-credentials --name ${azurerm_kubernetes_cluster.aks.name} --resource ${azurerm_resource_group.rg.name}"
}
