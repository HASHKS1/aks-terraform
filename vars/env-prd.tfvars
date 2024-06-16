#================================================================================================
# Environment Vars - prd
#================================================================================================
environment     = "prd"
subscription_id = "0a12401e-dad1-42a9-88f2-d8edd74a1696" # UPDATE HERE.
vnet            = { "aks" : { "vnet_name" : "vnet-aks", "vnet_cidr" : "192.168.0.0/16" } }
vnet_subnets = { "aks" : { "sub_name" : "snet-aks", "sub_cidr" : "192.168.1.0/24" },
"appgw" : { "sub_name" : "snet-appgw", "sub_cidr" : "192.168.2.0/24" } }
dns_name     = "lkhabir.com"
uai_name_aks = "aks-msi"
kv_name      = "akskv01"
random_string_kv = "rg-prd-0000111"

