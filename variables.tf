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
