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

data "azurerm_policy_definition" "policies" { # Data block to get a handle on the policy definition based on the display name. Maps display_name to the name of the build-in policy in Azure.
  for_each     = var.policies
  display_name = each.key
}

resource "random_integer" "policy_suffix" {
  min = 100
  max = 300
}

data "azurerm_resource_group" "resourcegroup" {
  for_each = var.policies
  name     = each.value.resource_group
}

resource "azurerm_resource_group_policy_assignment" "assignpolicy" {
  for_each             = var.policies
  name                 = "Assign-policy-${random_integer.policy_suffix.result}"
  policy_definition_id = data.azurerm_policy_definition.policies[each.key].id
  resource_group_id    = data.azurerm_resource_group.resourcegroup[each.key].id

  parameters = <<PARAMS
  {
   "${each.value.parameter_name}" : {
   "value" : ["${each.value.parameter_value}"]
   }
  }
  PARAMS
}
