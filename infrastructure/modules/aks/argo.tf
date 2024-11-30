resource "helm_release" "argocd_deployment" {
  count      = var.deploy_argo ? 1 : 0
  create_namespace = true
  name       = "argo-cd"
  chart      = "argo-cd"
  timeout    = 600
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster]

}