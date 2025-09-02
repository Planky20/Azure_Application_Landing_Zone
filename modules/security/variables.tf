variable "keyvaults" {
  type = map(object(
    {
      location            = string
      resource_group_name = string
    }
  ))
}

variable "policies" {
  type = map(object(
    {
      resource_group  = string
      parameter_name  = string
      parameter_value = string
    }
  ))
}
