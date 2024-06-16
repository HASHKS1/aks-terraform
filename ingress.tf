resource "azurerm_dns_zone" "ingress-public" {
  name                = local.dns-name
  resource_group_name = local.aks-resources-rg
}

resource "azurerm_dns_a_record" "ingress-public-A-record" {
  depends_on          = [azurerm_kubernetes_cluster.k8s, azurerm_public_ip.lbic_pip]
  name                = local.ingress-name
  zone_name           = azurerm_dns_zone.ingress-public.name
  resource_group_name = local.aks-resources-rg
  ttl                 = 3600
  records             = [azurerm_public_ip.lbic_pip.ip_address]
}

resource "azurerm_public_ip" "lbic_pip" {
  depends_on = [ local.aks-resources-nrg ]
  name                = "loadbalancer-ingressController-pip"
  location            = local.aks-rg-location
  resource_group_name = local.aks-resources-nrg
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "helm_release" "ingress_nginx_controller" {
  depends_on       = [azurerm_kubernetes_cluster.k8s,azurerm_public_ip.lbic_pip]
  name             = local.nginx-ingress-name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  values = [
    templatefile("./ingress-controller/values.yml",
      { pip_rg_name = local.aks-resources-nrg }
    )
  ]

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.lbic_pip.ip_address
  }

  lifecycle {
    create_before_destroy = false
  }
} 