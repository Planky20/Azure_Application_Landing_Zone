resource_groups = {
  network-grp = {
    location = "North Europe"
  },
  logging-grp = {
    location = "UK South"
  },
  security-grp = {
    location = "North Europe"
  },
  storage-grp = {
    location = "UK South"
  },
  db-grp = {
    location = "North Europe"
  }
}

environment = {
  production-hub-network = {
    virtual_network_address_space = "10.0.0.0/16"
    resource_group_name           = "network-grp"
    location                      = "North Europe"
    subnets = {
      GatewaySubnet = {
        subnet_address_prefix        = "10.0.1.0/24"
        network_security_group_rules = []
      }
      AzureBastionSubnet = {
        subnet_address_prefix        = "10.0.2.0/24"
        network_security_group_rules = []
      }
      AzureFirewallSubnet = {
        subnet_address_prefix        = "10.0.3.0/24"
        network_security_group_rules = []
      }
    }
  },
  app-network = {
    virtual_network_address_space = "10.1.0.0/16"
    resource_group_name           = "network-grp"
    location                      = "North Europe"
    subnets = {
      AppSubnet = {
        subnet_address_prefix = "10.1.0.0/24"
        network_security_group_rules = [ # Base-layer rule to deny all traffic
          {
            priority                   = 1000
            destination_port_range     = "*"
            access                     = "Deny"
            protocol                   = "Tcp"
            source_port_range          = "*"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      }
      WebSubnet = {
        subnet_address_prefix        = "10.1.1.0/24"
        network_security_group_rules = []
      }
    }
  }
}

log_analytics_workspaces = {
  security-log-workspace = {
    resource_group_name = "security-grp"
    location            = "UK South"
  },
  central-log-workspace = {
    resource_group_name = "logging-grp"
    location            = "UK South"
  }
}

storage_accounts = {
  securitystore = {
    resource_group_name      = "security-grp"
    location                 = "UK South"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    is_hns_enabled           = false
  },
  dataengstore = {
    resource_group_name      = "storage-grp"
    location                 = "North Europe"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    is_hns_enabled           = true
  }
}

dbapp_environment = {
  production = {
    server = {
      enggsqlserver = {
        resource_group_name = "db-grp"
        location            = "North Europe"
        databases = {
          datadb = {
            sku = "S0"
          }
        }
      }
      centralsqlserver = {
        resource_group_name = "db-grp"
        location            = "North Europe"
        databases = {
          centraldb = {
            sku = "S0"
          }
        }
      }
    }
  }
}
