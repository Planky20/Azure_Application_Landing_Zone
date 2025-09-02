locals {
  virtual_network_details = (flatten([ # Deconstruction and flattening of VNET variable, to have a flat structure containing only VNET name, address space, RG name and location
    for virtualnetwork_key, virtualnetwork in var.environment :
    {
      virtual_network_name          = virtualnetwork_key
      virtual_network_address_space = virtualnetwork.virtual_network_address_space
      resource_group_name           = virtualnetwork.resource_group_name
      location                      = virtualnetwork.location
    }
  ]))

  subnet_details = (flatten([
    for virtualnetwork_key, virtualnetwork in var.environment : [
      for subnet_key, subnets in virtualnetwork.subnets :
      {
        subnet_name           = subnet_key
        virtual_network_name  = virtualnetwork_key
        subnet_address_prefix = subnets.subnet_address_prefix
        resource_group_name   = virtualnetwork.resource_group_name
        location              = virtualnetwork.location
    }]
  ]))

  network_security_group_details = (flatten([
    for virtualnetwork_key, virtualnetwork in var.environment : [
      for subnet_key, subnets in virtualnetwork.subnets :
      {
        virtual_network_name         = virtualnetwork_key
        subnet_name                  = subnet_key
        resource_group_name          = virtualnetwork.resource_group_name
        location                     = virtualnetwork.location
        network_security_group_rules = subnets.network_security_group_rules
    }]
  ]))

  database_details = (flatten([
    for server_key, server in var.dbapp_environment.production.server : [
      for database_key, database in server.databases :
      {
        server_name         = server_key
        database_name       = database_key
        database_sku        = database.sku
        resource_group_name = server.resource_group_name
        location            = server.location
      }
    ]
  ]))

}
