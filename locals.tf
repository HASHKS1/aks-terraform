locals {

  aks-resources-rg = azurerm_resource_group.rg.name

  aks-rg-location = azurerm_resource_group.rg.location

  aks-resources-nrg = join("-", [azurerm_resource_group.rg.name, "nrg"])

  aks-resources-nrg-id = "/subscriptions/${var.subscription_id}/resourcegroups/${azurerm_resource_group.rg.name}-nrg"

  aks-name = "aks-${var.environment}-${var.application_code}-${var.unique_id}"

  aks-dns-prefix     = "aks-${var.environment}-${var.application_code}-${var.unique_id}-dns"
  dns-name           = "lkhabir.com"
  ingress-name       = "devops4u-tech"
  nginx-ingress-name = "ingress-nginx"

}
