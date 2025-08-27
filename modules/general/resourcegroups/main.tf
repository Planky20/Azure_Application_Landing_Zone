resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.key
  location = each.value.location
}
