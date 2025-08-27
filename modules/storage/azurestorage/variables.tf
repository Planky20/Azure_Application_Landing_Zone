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
