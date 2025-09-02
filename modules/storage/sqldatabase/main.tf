resource "random_integer" "sqlserver_suffix" {
  min = 7777
  max = 10000
}

resource "azurerm_mssql_server" "sqlserver" {
  for_each                     = { for detail in var.database_details : detail.server_name => detail } # A map
  name                         = "${each.key}${random_integer.sqlserver_suffix.result}"
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Azure@777"
}

resource "azurerm_mssql_database" "databases" {
  for_each     = { for detail in var.database_details : detail.database_name => detail } # A map
  name         = each.key
  server_id    = azurerm_mssql_server.sqlserver["${each.value.server_name}"].id # Because mssql server block is a map, that's why we need to address it like this
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = each.value.database_sku
}
