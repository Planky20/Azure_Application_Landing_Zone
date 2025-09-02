resource "random_integer" "keyvault_suffix" {
  min = 3333
  max = 9999
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvaults" {
  for_each                   = var.keyvaults
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  name                       = "${each.key}${random_integer.keyvault_suffix.result}"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
}
