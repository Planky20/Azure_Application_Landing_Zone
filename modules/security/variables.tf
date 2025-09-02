variable "keyvaults" {
  type = map(object(
    {
      location            = string
      resource_group_name = string
    }
  ))
}
