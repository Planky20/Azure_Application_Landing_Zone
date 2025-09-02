variable "resource_groups" {
  type = map(object(
    {
      location = string
    }
  ))
}

variable "environment" {
  type = map(object(
    {
      virtual_network_address_space = string
      resource_group_name           = string
      location                      = string
      subnets = map(object(
        {
          subnet_address_prefix = string
          network_security_group_rules = list(object(
            {
              priority                   = number
              destination_port_range     = string
              access                     = string
              protocol                   = string
              source_port_range          = string
              source_address_prefix      = string
              destination_address_prefix = string
            }
          ))
        }
      ))
    }
  ))
}

variable "log_analytics_workspaces" {
  type = map(object(
    {
      resource_group_name = string
      location            = string
    }
  ))
}

variable "storage_accounts" {
  type = map(object(
    {
      location                 = string
      resource_group_name      = string
      account_tier             = string
      account_replication_type = string
      account_kind             = string
      is_hns_enabled           = bool # Hierarchial namespace (support Azure Data Lake Storage Gen 2)
    }
  ))
}

variable "dbapp_environment" {
  type = map(object(
    {
      server = map(object(
        {
          resource_group_name = string
          location            = string
          databases = map(object(
            {
              sku = string
            }
          ))
        }
      ))
    }
  ))
}

variable "keyvaults" {
  type = map(object(
    {
      location            = string
      resource_group_name = string
    }
  ))
}
