data "azurerm_client_config" "current" {}

#needed
module "resource_group" {
  for_each            = var.resourceGroups
  source              = "Azure/resource-group/azurerm"
  location            = each.value.location
  resource_group_name = each.value.name
  tags                = each.value.tags
}

module "management_user_assigned_identity" {
  source              = "Azure/user-assigned-identity/azurerm"
  name                = var.managementuan
  location            = var.mainLocation
  resource_group_name = var.resourceGroups["netRG"].name
  depends_on          = [module.resource_group]
}

#storage account
module "storage_account" {
  for_each                        = var.storageAccounts
  source                          = "Azure/storage-account/azurerm"
  account_tier                    = each.value.account_tier
  account_replication_type        = each.value.account_replication_type
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  name                            = each.value.name
  user_assigned_identity_id       = module.management_user_assigned_identity.id
  identity_type                   = "UserAssigned"
  identity_ids                    = [module.management_user_assigned_identity.id]
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  queue_encryption_key_type       = "Account"
  table_encryption_key_type       = "Account"
  depends_on                      = [module.resource_group, module.management_user_assigned_identity]
}

# virtual networks
module "management_vnet_module" {
  for_each                     = var.managementVirtualNetworks
  source                       = "Azure/virtual-network/azurerm"
  virtual_network_name         = each.value.VirtualNetworkName
  resource_group_name          = var.resourceGroups["netRG"].name
  location                     = var.mainLocation
  address_space                = [each.value.address_space]
  tags                         = { environment = var.environment }
  depends_on                   = [module.resource_group]
}

#needed
# subnets
module "management_subnet_module" {
  for_each                  = var.managementSubnets
  source                    = "Azure/subnet/azurerm"
  resource_group_name       = var.resourceGroups["netRG"].name
  virtual_network_name      = each.value.vnet_name
  subnet_name               = each.value.name
  address_prefixes          = [each.value.addressPrefix]
  # route_table_id            = each.value.routeTableName == null ? null : "/subscriptions/${each.value.subscriptionId}/resourceGroups/${var.resourceGroups["netRG"].name}/providers/Microsoft.Network/routeTables/${each.value.routeTableName}"
  # network_security_group_id = each.value.networkSecurityGroupId == null || each.value.subscriptionId == null ? null : "/subscriptions/${each.value.subscriptionId}/resourceGroups/${var.resourceGroups["netRG"].name}/providers/Microsoft.Network/networkSecurityGroups/${each.value.networkSecurityGroupId}"
  depends_on                = [module.resource_group, module.management_vnet_module]
  service_endpoints         = ["Microsoft.KeyVault"]
}


# Virtual Hub
module "management_vhub_module" {
  for_each                   = var.managementVHub
  source                     = "Azure/virtual-hub/azurerm"
  name                       = each.value.name
  resource_group_name        = var.resourceGroups["netRG"].name
  location                   = each.value.location
  vwan_id                    = module.management_vwan_module[each.value.vwan_key].virtual_wan_id
  address_prefix             = each.value.address_prefix
  create_firewall_policy     = try(each.value.create_firewall_policy, true)
  firewall_policy_id         = try(each.value.firewall_policy_id, null)
  vnet_connections           = {for conn_key, conn in try(each.value.vnet_connections, {}) : conn_key => {
    vnet_id                  = module.management_vnet_module[conn.vnet_key].id
  } }
  depends_on                 = [module.management_vwan_module, module.resource_group]
}

