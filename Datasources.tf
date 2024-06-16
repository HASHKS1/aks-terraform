#================================================================================================
# Data Sources
#================================================================================================

data "azurerm_kubernetes_cluster" "main_aks" {
  depends_on          = [azurerm_kubernetes_cluster.k8s]
  name                = local.aks-name
  resource_group_name = local.aks-resources-rg
}

data "azurerm_client_config" "current" {}

