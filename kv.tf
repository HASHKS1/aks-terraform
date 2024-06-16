resource "azurerm_key_vault" "aks_kv" {
  name                       = "${var.kv_name}-${var.random_string_kv}"
  location                   = local.aks-rg-location
  resource_group_name        = local.aks-resources-rg
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
}

resource "azurerm_key_vault_access_policy" "kv_user_assigned_identity" {
  depends_on         = [azurerm_user_assigned_identity.uai_aks]
  key_vault_id       = azurerm_key_vault.aks_kv.id
  tenant_id          = var.tenant_id
  object_id          = azurerm_user_assigned_identity.uai_aks.principal_id
  secret_permissions = ["Get", "List", "Set", "Delete"]
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id       = azurerm_key_vault.aks_kv.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  secret_permissions = ["Get", "List", "Set", "Delete", "Purge"]
}

resource "azurerm_key_vault_secret" "aks_app_secrets" {
  name         = "aks-title"
  value        = "Secret AKS Cluster app id : aks_0000111"
  key_vault_id = azurerm_key_vault.aks_kv.id
  depends_on = [
    azurerm_key_vault.aks_kv,
    azurerm_key_vault_access_policy.this
  ]
}