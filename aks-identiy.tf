#  Attach role to the system identity 
resource "azurerm_user_assigned_identity" "uai_aks" {
  name                = var.uai_name_aks
  resource_group_name = local.aks-resources-rg
  location            = local.aks-rg-location
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  depends_on           = [azurerm_kubernetes_cluster.k8s]
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope                = local.aks-resources-nrg-id
}