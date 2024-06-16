# Create a resource group.
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.resource_group_name_prefix}-${var.environment}-${var.application_code}-${var.unique_id}"
}