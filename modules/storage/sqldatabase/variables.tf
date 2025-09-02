variable "database_details" {
  type = list(object(
    {
      server_name         = string
      database_name       = string
      database_sku        = string
      resource_group_name = string
      location            = string
    }
  ))
}
