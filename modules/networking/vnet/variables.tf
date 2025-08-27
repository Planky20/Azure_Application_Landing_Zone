variable "virtual_network_details" {
  type = list(object(
    {
      virtual_network_name          = string
      virtual_network_address_space = string
      resource_group_name           = string
      location                      = string
    }
  ))
}

variable "subnet_details" {
  type = list(object(
    {
      subnet_name           = string
      virtual_network_name  = string
      subnet_address_prefix = string
      resource_group_name   = string
    }
  ))
}

variable "network_security_group_details" {
  type = list(object(
    {
      virtual_network_name = string
      subnet_name          = string
      resource_group_name  = string
      location             = string
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
