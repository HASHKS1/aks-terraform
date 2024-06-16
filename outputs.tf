#================================================================================================
# Outputs variables
#================================================================================================

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].password
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].username
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

output "aks_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config
  sensitive = true
}

output "uai_aks_clientID" {
  value = azurerm_user_assigned_identity.uai_aks.client_id
}

# Required for helm provider config.

output "aks_host" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].host
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "fqdn" { value = data.azurerm_kubernetes_cluster.main_aks.fqdn }

output "netprofile" { value = data.azurerm_kubernetes_cluster.main_aks.network_profile }