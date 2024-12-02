# Deploy ArgoCD using the Helm provider.
resource "helm_release" "argocd_deployment" {
  count            = var.deploy_argo ? 1 : 0                      # Deploy ArgoCD only if 'deploy_argo' is true.
  create_namespace = true                                         # Automatically create the namespace if it doesn't exist.
  name             = "argo-cd"                                   # Release name for the ArgoCD Helm deployment.
  chart            = "argo-cd"                                   # Name of the Helm chart.
  timeout          = 600                                         # Timeout for the Helm release in seconds.
  namespace        = "argocd"                                    # Kubernetes namespace to deploy ArgoCD.
  repository       = "https://argoproj.github.io/argo-helm"      # Repository URL for the ArgoCD Helm chart.

  # Set custom values for the Helm chart.
  set {
    name  = "server.service.type"                                # Name of the Helm value to override.
    value = "LoadBalancer"                                       # Set the ArgoCD service type to 'LoadBalancer'.
  }

  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster]   # Ensure the AKS cluster is deployed before deploying ArgoCD.
}

# Deploy Reloader using the Helm provider.
resource "helm_release" "reloader_deployment" {
  count      = var.deploy_reloader ? 1 : 0                       # Deploy Reloader only if 'deploy_reloader' is true.
  name       = "stakater"                                       # Release name for the Reloader Helm deployment.
  chart      = "reloader"                                       # Name of the Helm chart.
  namespace  = "default"                                        # Kubernetes namespace to deploy Reloader.
  timeout    = 600                                             # Timeout for the Helm release in seconds.
  repository = "https://stakater.github.io/stakater-charts"     # Repository URL for the Reloader Helm chart.

  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster]  # Ensure the AKS cluster is deployed before deploying Reloader.
}
