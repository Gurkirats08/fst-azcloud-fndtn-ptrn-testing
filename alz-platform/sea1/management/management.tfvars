# global variables
environment  = "dev"
mainLocation = "southeastasia"
tags = {
  environment = "management"
}
subscriptionId = "xyz"

# resource group
resourceGroups = {
  netRG = {
    name     = "rg-net-management-sea-002"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  },
  laRG = {
    name     = "rg-gov-management-sea-002"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
  paasRG = {
    name     = "rg-paas-management-sea-001"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
  backupRG = {
    name     = "rg-backup-management-sea-002"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
  secRG = {
    name     = "rg-sec-management-sea-001"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
}

#PaaS RG resources
# storage account
storageAccounts = {
  sa1 = {
    name                      = "stsmanagementtest01"
    resource_group_name       = "rg-paas-management-sea-001"
    location                  = "southeastasia"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    shared_access_key_enabled = false
  }
}

# Network Watcher [created automatically]
network_watcher_rg   = "NetworkWatcherRG"
network_watcher_name = "NetworkWatcher_southeastasia"


# virtual network
managementVirtualNetworks = {
  vnet1 = {
    subscriptionId     = "xyz"
    VirtualNetworkName = "vnet-management-sea-001"
    address_space      = "10.64.0.0/23"
    sku_name           = "Standard"
    location           = "southeastasia"
  }
  vnet2 = {
    subscriptionId     = "xyz"
    VirtualNetworkName = "vnet-management-sea-002"
    address_space      = "10.65.0.0/23"
    sku_name           = "Standard"
    location           = "southeastasia"
  }
}

managementSubnets = {
  Gatewaysubnet = {
    vnet_key               = "vnet1"
    name                   = "gatewaysubnet"
    addressPrefix          = "10.64.0.0/25"
    vnet_name              = "vnet-management-sea-001"
    networkSecurityGroupId = null
    routeTableName         = "rt-management-sea-001-1"
    subscriptionId         = "xyz"
  },
  AzureFirewallSubnet = {
    vnet_key               = "vnet1"
    name                   = "AzureFirewallSubnet"
    addressPrefix          = "10.64.0.128/25"
    vnet_name              = "vnet-management-sea-001"
    networkSecurityGroupId = null
    routeTableName         = "rt-management-sea-001-2"
    subscriptionId         = "xyz"
  }
}