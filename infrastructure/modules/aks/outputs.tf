# Output the client certificate used for authenticating with the Kubernetes cluster.
# Marked as sensitive since it contains sensitive information.
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate
  sensitive = true
}

# Output the name of the Kubernetes cluster.
output "cluster_name" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.name
}

# Output the name of the resource group containing the Kubernetes cluster.
output "resource_group_name" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.resource_group_name
}

# Output the client key used for authenticating with the Kubernetes cluster.
# Marked as sensitive since it contains sensitive information.
output "client_key" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key
  sensitive = true
}

# Output the cluster CA certificate used for TLS authentication with the Kubernetes cluster.
# Marked as sensitive since it contains sensitive information.
output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate
  sensitive = true
}

# Output the API server endpoint of the Kubernetes cluster.
output "host" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host
}

# Output the raw kubeconfig data for the Kubernetes cluster.
# Marked as sensitive since it contains authentication details.
output "kube_config" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
  sensitive = true
}

# Output the object ID of the identity used by the Kubernetes cluster's kubelet.
output "aks_identity" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id
}
