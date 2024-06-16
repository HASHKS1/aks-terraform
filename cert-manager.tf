resource "helm_release" "cert_manager" {
  depends_on       = [azurerm_kubernetes_cluster.k8s]
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.13.3"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
  lifecycle {
    ignore_changes = [
      set,
    ]
  }
}