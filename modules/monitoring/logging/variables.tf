variable "log_analytics_workspaces" {
  type = map(object(
    {
      resource_group_name = string
      location            = string
    }
  ))
}
