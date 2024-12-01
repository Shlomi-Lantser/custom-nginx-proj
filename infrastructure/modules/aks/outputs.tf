output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate
  sensitive = true
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.name
}

output "resource_group_name" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.resource_group_name
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw

  sensitive = true
}

output "aks_identity" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id
}