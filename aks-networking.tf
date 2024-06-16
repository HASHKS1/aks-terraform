# Create a vnet.
resource "azurerm_virtual_network" "vn" {
  name                = var.vnet["aks"]["vnet_name"]
  location            = local.aks-rg-location
  resource_group_name = local.aks-resources-rg
  address_space       = [var.vnet["aks"]["vnet_cidr"]]
}

# Create a subnet for aks nodes and pods.
resource "azurerm_subnet" "subnet_aks" {
  name                 = var.vnet_subnets["aks"]["sub_name"]
  resource_group_name  = local.aks-resources-rg
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = [var.vnet_subnets["aks"]["sub_cidr"]]
}