#================================================================================================
# Provider Configuration
#================================================================================================

terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  tenant_id       = var.tenant_id
  client_id       = var.terraform_sp
  subscription_id = var.subscription_id
  # client_secret = Ensure $env:ARM_CLIENT_SECRET is set locally
}

provider "helm" {
  # debug   = true
  kubernetes {
    host = data.azurerm_kubernetes_cluster.main_aks.kube_config[0].host

    client_key             = base64decode(data.azurerm_kubernetes_cluster.main_aks.kube_config[0].client_key)
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.main_aks.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main_aks.kube_config[0].cluster_ca_certificate)
  }
}