module "resource-groups" {
  source          = "./modules/general/resourcegroups"
  resource_groups = var.resource_groups
}

module "network" {
  source                         = "./modules/networking/vnet"
  subnet_details                 = local.subnet_details
  virtual_network_details        = local.virtual_network_details
  network_security_group_details = local.network_security_group_details
  depends_on                     = [module.resource-groups]
}

module "logging" {
  source                   = "./modules/monitoring/logging"
  log_analytics_workspaces = var.log_analytics_workspaces
}

module "azure-storage" {
  source           = "./modules/storage/azurestorage"
  storage_accounts = var.storage_accounts
}

module "databases" {
  source           = "./modules/storage/sqldatabase"
  database_details = local.database_details
}
