resource "random_integer" "storage_account_suffix" {
  min = 3333
  max = 9999
}

resource "azurerm_storage_account" "storage_account" {
  for_each                 = var.storage_accounts
  name                     = "${each.key}${random_integer.storage_account_suffix.result}"
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  account_kind             = each.value.account_kind
  is_hns_enabled           = each.value.is_hns_enabled
}
