# Create the aks cluster.
resource "azurerm_kubernetes_cluster" "k8s" {
  depends_on = [
    azurerm_resource_group.rg
  ]
  location            = local.aks-rg-location
  resource_group_name = local.aks-resources-rg
  node_resource_group = local.aks-resources-nrg
  name                = local.aks-name
  dns_prefix          = local.aks-dns-prefix

  # For workload identity
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # Set the default node pool config.
  default_node_pool {
    name           = "agentpool"
    node_count     = "1"
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.subnet_aks.id # Nodes and pods will receive ip's from here.
  }

  # Set the identity profile.
  identity {
    type         = "UserAssigned"
    identity_ids = ["${azurerm_user_assigned_identity.uai_aks.id}"]
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
  role_based_access_control_enabled = true


  # Set the network profile.
  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

}

// federated identity object 
resource "azurerm_federated_identity_credential" "this" {
  depends_on          = [azurerm_kubernetes_cluster.k8s]
  name                = "aksfederatedidentity"
  resource_group_name = local.aks-resources-rg
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.k8s.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.uai_aks.id
  subject             = "system:serviceaccount:default:aks01-identity-sa" #  UPDATE based on system:serviceaccount:namespace/sa
}
