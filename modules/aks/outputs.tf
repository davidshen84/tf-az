output "aks_get_credential" {
  value = "az aks get-credentials --name ${azurerm_kubernetes_cluster.aks.name} --resource ${var.rg.name}"
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}
