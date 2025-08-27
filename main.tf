module "resource-groups" {
  source          = "./modules/general/resourcegroups"
  resource_groups = var.resource_groups
}
