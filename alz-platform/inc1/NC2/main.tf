data "azurerm_client_config" "current" {}

#Multiple Resource Group
module "nc2_resource_group" {
  for_each            = var.nc2resourceGroups
  source              = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/resourcegroup/v1.0?ref=main"
  location            = var.mainLocation
  resource_group_name = each.value.name
  tags                = each.value.tags
}

#---------------------------------------------------------------------------------------------------
#Network resources in Network RG 

module "nc2_vnet_module" {
  for_each             = var.nc2VirtualNetworks
  source               = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/virtualnetwork/v1.0?ref=main"
  virtual_network_name = each.value.VirtualNetworkName
  resource_group_name  = each.value.resourceGroupName
  location             = var.mainLocation
  address_space        = [each.value.address_space]
  tags                 = { }
  depends_on           = [module.nc2_resource_group]
}

# subnets
module "nc2_subnet_module" {
  for_each                  = var.nc2Subnets
  source                    = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/subnet/v1.0?ref=main"
  resource_group_name       = each.value.resourceGroupName
  virtual_network_name      = each.value.vnet_name
  subnet_name               = each.value.name
  address_prefixes          = [each.value.addressPrefix]
  route_table_id            = each.value.routeTableName == null ? null : "/subscriptions/${each.value.subscriptionId}/resourceGroups/${var.nc2resourceGroups["netRG"].name}/providers/Microsoft.Network/routeTables/${each.value.routeTableName}"
  network_security_group_id = each.value.nsgname == null ? null : "/subscriptions/${each.value.subscriptionId}/resourceGroups/${var.nc2resourceGroups["netRG"].name}/providers/Microsoft.Network/networkSecurityGroups/${each.value.nsgname}"
  depends_on                = [module.nc2_resource_group, module.nc2_vnet_module, module.nc2_nsg_module, module.nc2_route_table_module]
  service_endpoints         = ["Microsoft.KeyVault"]
}

module "nc2_nsg_module" {
  source                  = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/networksecuritygroup/v1.0?ref=main"
  main_location           = var.mainLocation
  environment             = var.environment
  network_security_groups = var.nc2NetworkSecurityGroups
  depends_on              = [ module.nc2_resource_group]
}

module "nc2_route_table_module" {
  for_each            = var.nc2RouteTables
  source              = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/routetable/v1.0?ref=main"
  resource_group_name = each.value.resourceGroupName
  route_table_name    = each.value.routeTableName
  location            = var.mainLocation
  tags                = { }
  route_table = {
    bgp_route_propagation_enabled = each.value.enableBgpRoutePropagation
    routes                        = each.value.routes
  }
  depends_on = [ module.nc2_resource_group ]
}


#----------------------------------------------------------------------------------------------------
#Migration Resources RG

# Private Endpoint

# module "nc2_private_endpoint" {
#   for_each                       = var.connPrivateEndpoint
#   source                         = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/=main"
#   private_endpoint_name          = each.value.private_endpoint_name
#   resource_group_name            = each.value.resource_group_name
#   location                       = each.value.location
#   subnet_id                      = module.nc2_subnet_module[each.value.subnet_id].id
#   private_dns_zone_id            = module.dns_zone_module[each.value.private_dns_zone_id].id
#   private_connection_resource_id = each.value.private_connection_resource_id
#   subresource_names              = each.value.subresource_names
#   depends_on                     = [module.nc2_subnet_module]
# }

#----------------------------------------------------------------------------------------------------
#PaaS Resources RG


# # Storage Account

# module "nc2_storage_account" {
#   source                        = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/=main"
#   account_tier                  = "Standard"
#   account_replication_type      = "LRS"
#   resource_group_name           = var.nsgFlowstorageAccountResourceGroupName
#   location                      = var.mainLocation
#   name                          = var.nsgFlowstorageAccountName
#   key_vault_key_id              = resource.azurerm_key_vault_managed_hardware_security_module_key.hsm-key.id
#   user_assigned_identity_id     = module.conn_user_assigned_identity.id
#   identity_type                 = "UserAssigned"
#   identity_ids                  = [module.conn_user_assigned_identity.id]
#   public_network_access_enabled = false
#   shared_access_key_enabled     = false
#   queue_encryption_key_type     = "Account"
#   table_encryption_key_type     = "Account"
#   depends_on                    = []
# }

# #--------------------------------------------------------------------------------

# #Resource Locks
# module "nc2_resource_lock" {
#   for_each            = var.connResourceLocks
#   source              = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/=main"
#   resource_group_name = each.value.resource_group_name
#   name                = each.value.name
#   lock_level          = each.value.lock_level
#   notes               = each.value.notes
#   resource_name       = each.value.resource_name
#   resource_type       = each.value.resource_type
#   subscription_id     = data.azurerm_client_config.current.subscription_id
#   depends_on          = [module.nc2_resource_group]

# }

# #-----------------------------------------------------------------------------------------

# # #diagnostics logs
# module "nc2_diagnostic_setting" {
#   for_each                       = var.diagnostic_logs
#   source                         = "git::https://github.com/Gurkirats08/fst-azcloud-goldrepo-testing.git//modules-hub/terraform-modules/=main"
#   name                           = each.value.name
#   target_resource_id             = each.value.target_resource_id
#   storage_account_id             = each.value.storage_account_id
#   log_analytics_workspace_id     = each.value.log_analytics_workspace_id
#   eventhub_name                  = each.value.eventhub_name
#   eventhub_authorization_rule_id = each.value.eventhub_authorization_rule_id
#   logs_categories                = each.value.logs_categories
#   metrics                        = each.value.metrics
#   depends_on                     = [module.nc2_storage_account]
# }