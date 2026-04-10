# global variables
environment  = "dev"
mainLocation = "centralindia"
tags = {
  environment = "sharedservices"
}
subscriptionId = "f35b495f-d039-427e-9d9b-17c8bfc622b8"

# resource group
resourceGroups = {
  netRG = {
    name     = "rg-net-sharedservices-inc-002"
    location = "centralindia"
    tags = {
      team = "Sec-Team"
    }
  },
  laRG = {
    name     = "rg-gov-sharedservices-inc-001"
    location = "centralindia"
    tags = {
      team = "Sec-Team"
    }
  }
  paasRG = {
    name     = "rg-paas-sharedservices-inc-001"
    location = "centralindia"
    tags = {
      team = "Sec-Team"
    }
  }
  backupRG = {
    name     = "rg-backup-sharedservices-inc-002"
    location = "centralindia"
    tags = {
      team = "Sec-Team"
    }
  }
  secRG = {
    name     = "rg-sec-sharedservices-inc-001"
    location = "centralindia"
    tags = {
      team = "Sec-Team"
    }
  }
}

#PaaS RG resources
# storage account
storageAccounts = {
  sa1 = {
    name                      = "stssharedinctest01"
    resource_group_name       = "rg-paas-sharedservices-inc-001"
    location                  = "centralindia"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    shared_access_key_enabled = false
  }
}

# Network Watcher [created automatically]
network_watcher_rg   = "NetworkWatcherRG"
network_watcher_name = "NetworkWatcher_centralindia"


# virtual network
sharedservicesVirtualNetworks = {
  vnet1 = {
    resourceGroupName  = "rg-net-sharedservices-inc-001"
    subscriptionId     = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
    VirtualNetworkName = "vnet-sharedservices-inc-001"
    address_space      = "10.64.0.0/23"
    sku_name           = "Standard"
    location           = "centralindia"
  }
  vnet2 = {
    resourceGroupName  = "rg-net-sharedservices-inc-001"
    subscriptionId     = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
    VirtualNetworkName = "vnet-sharedservices-inc-002"
    address_space      = "10.65.0.0/23"
    sku_name           = "Standard"
    location           = "centralindia"
  }
}

sharedservicesSubnets = {
  Gatewaysubnet = {
    resourceGroupName      = "rg-net-sharedservices-inc-001"
    vnet_key               = "vnet1"
    name                   = "gatewaysubnet"
    addressPrefix          = "10.64.0.0/25"
    vnet_name              = "vnet-sharedservices-inc-001"
    networkSecurityGroupId = null
    routeTableName         = "rt-sharedservices-inc-001-1"
    subscriptionId         = "3e3a2118-a39a-4ff7-9df7-104c3e1e611a"
  },
  AzureFirewallSubnet = {
    resourceGroupName      = "rg-net-sharedservices-inc-001"
    vnet_key               = "vnet1"
    name                   = "AzureFirewallSubnet"
    addressPrefix          = "10.64.0.128/25"
    vnet_name              = "vnet-sharedservices-inc-001"
    networkSecurityGroupId = null
    routeTableName         = "rt-sharedservices-inc-001-2"
    subscriptionId         = "3e3a2118-a39a-4ff7-9df7-104c3e1e611a"
  }
  snet1 = {
    resourceGroupName      = "rg-net-sharedservices-inc-001"
    vnet_key               = "vnet1"
    name                   = "snet1-testing"
    addressPrefix          = "10.64.1.0/25"
    vnet_name              = "vnet-sharedservices-inc-001"
    networkSecurityGroupId = "nsg-sharedservices-inc-001"
    routeTableId           = null
    subscriptionId         = "3e3a2118-a39a-4ff7-9df7-104c3e1e611a"
  }

   snet2 = {
    resourceGroupName      = "rg-net-sharedservices-inc-001"
    vnet_key               = "vnet2"
    name                   = "snet2-testing"
    addressPrefix          = "10.65.1.0/25"
    vnet_name              = "vnet-sharedservices-inc-002"
    networkSecurityGroupId = "nsg-sharedservices-inc-002"
    routeTableId           = null
    subscriptionId         = "3e3a2118-a39a-4ff7-9df7-104c3e1e611a"
  }
}

sharedservicesuan = "ual-sharedservices-inc-002"
###-----------------------------------------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------
