data "azurerm_client_config" "current" {}

# Multiple Resource Group
module "resource_group" {
  for_each            = var.resourceGroups
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/resourcegroup/v1.0?ref=main"
  location            = each.value.location
  resource_group_name = each.value.name
  tags                = each.value.tags
}

#----------------------------------------------------------------
#Network resources in Network RG 

# mgmt NSGs
module "mgmt_nsg_module" {
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/networksecuritygroup/v1.0?ref=main"
  main_location           = var.mainLocation
  environment             = var.environment
  network_security_groups = var.mgmtNetworkSecurityGroups
  depends_on = [ module.resource_group]
}

# mgmt virtual networks
module "mgmt_vnet_module" {
  for_each                     = var.mgmtVirtualNetworks
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/virtualnetwork/v1.0?ref=main"
  virtual_network_name         = each.value.VirtualNetworkName
  resource_group_name          = each.value.resourceGroupName
  location                     = var.mainLocation
  address_space                = [each.value.address_space]
  tags                         = { "environment" : var.environment }
  depends_on                   = [module.resource_group]
}

# mgmt subnets
module "mgmt_subnet_module" {
  for_each                          = var.mgmtSubnets
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/subnet/v1.0?ref=main"
  resource_group_name               = each.value.resourceGroupName
  virtual_network_name              = each.value.vnet_name
  subnet_name                       = each.value.name
  address_prefixes                  = [each.value.addressPrefix]
  route_table_id                    = each.value.rtName == null ? null : "/subscriptions/${each.value.subscriptionId}/resourceGroups/${var.resourceGroups["netRG"].name}/providers/Microsoft.Network/routeTables/${each.value.rtName}" #each.value.routeTableId
  private_endpoint_network_policies = var.private_endpoint_network_policies
  network_security_group_id         = each.value.nsgName == null ? null : "/subscriptions/${each.value.subscriptionId}/resourceGroups/${var.resourceGroups["netRG"].name}/providers/Microsoft.Network/networkSecurityGroups/${each.value.nsgName}"
  depends_on                        = [module.resource_group, module.mgmt_vnet_module, module.mgmt_nsg_module, module.mgmt_route_table_module]
}

# route table mgmt
module "mgmt_route_table_module" {
  for_each            = var.mgmtRouteTables
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/routetable/v1.0?ref=main"
  resource_group_name = each.value.resourceGroupName
  route_table_name    = each.value.routeTableName
  location            = var.mainLocation
  tags                = { "environment" : var.environment }
  route_table = {
    bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled
    routes                        = each.value.routes
  }
  depends_on = [module.resource_group]
}


# mgmt user assigned identity
module "mgmt_user_assigned_identity" {
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/userassignedidentity/v1.0?ref=main"
  for_each            = var.userAssignedIdentityName
  name                = each.value.uai_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  depends_on          = [module.resource_group, module.mgmt_route_table_module]
}

# # mgmt Storage Account
module "mgmt_storage_account" {
  for_each                        = var.mgmtStorageAccounts
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/storageaccount/v1.0?ref=main"
  account_tier                    = each.value.account_tier
  account_replication_type        = each.value.account_replication_type
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  name                            = each.value.name
  user_assigned_identity_id       = module.mgmt_user_assigned_identity["uai1"].id
  identity_type                   = "UserAssigned"
  identity_ids                    = [module.mgmt_user_assigned_identity["uai1"].id]
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  queue_encryption_key_type       = "Account"
  table_encryption_key_type       = "Account"
  depends_on                      = [module.resource_group, module.mgmt_user_assigned_identity]
}

module "mgmt_log_analytics_workspace_module" {
  source = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/loganalytics/v1.0?ref=main"
  workspaces = var.mgmtLogAnalyticsWorkspaces
  location   = var.mainLocation
  depends_on = [module.resource_group]
}