resource "azurerm_virtual_network" "virtual_network" {
  for_each            = { for network in var.virtual_network_details : network.virtual_network_name => network } # It will construct a map, in which the vnet name is the KEY and the entire NETWORK object is the VALUE
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [each.value.virtual_network_address_space]
}

resource "azurerm_subnet" "network_subnets" {
  for_each             = { for subnet in var.subnet_details : subnet.subnet_name => subnet } # It will construct a map, in which the subnet name is the KEY, and the entire SUBNET object is the VALUE.
  name                 = "${each.key}subnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = [each.value.subnet_address_prefix]
  depends_on           = [azurerm_virtual_network.virtual_network]
}

resource "azurerm_network_security_group" "network_security_group" {
  for_each            = { for subnet in var.network_security_group_details : subnet.subnet_name => subnet if length(subnet.network_security_group_rules) != 0 } # It will construct a map, the KEY will be the subnet name, the entire SUBNET object is the VALUE. Contains IF condition - it will only create NSG for the subnets if there are NSG rules specified in it. (In this particular case NSG will be created only for the AppSubnet)
  name                = "${each.key}_nsg"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  dynamic "security_rule" {
    for_each = each.value.network_security_group_rules
    content {
      name                       = "${security_rule.value.access}-${security_rule.value.protocol}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }


}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each                  = { for subnet in var.network_security_group_details : subnet.subnet_name => subnet if length(subnet.network_security_group_rules) != 0 } # It will construct a map, the KEY will be the subnet name, and the subnet OBJECT will be the VALUE. It will only create one association for the AppSubnet, because there is an IF condition specified.
  subnet_id                 = azurerm_subnet.network_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.network_security_group[each.key].id
}
