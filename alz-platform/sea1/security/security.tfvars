# global variables
environment  = "dev"
mainLocation = "southeastasia"
tags = {
  environment = "security"
}
subscriptionId = "abc"

# resource group
resourceGroups = {
  netRG = {
    name     = "rg-net-security-sea-002"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  },
  laRG = {
    name     = "rg-gov-security-sea-002"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
  paasRG = {
    name     = "rg-paas-security-sea-001"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
  backupRG = {
    name     = "rg-backup-security-sea-002"
    location = "southeastasia"
    tags = {
      team = "Sec-Team"
    }
  }
  secRG = {
    name     = "rg-sec-security-sea-001"
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
    name                      = "stssecuritytest01"
    resource_group_name       = "rg-paas-security-sea-001"
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
securityVirtualNetworks = {
  vnet1 = {
    subscriptionId     = "abc"
    VirtualNetworkName = "vnet-security-sea-001"
    address_space      = "10.64.0.0/23"
    sku_name           = "Standard"
    location           = "southeastasia"
  }
  vnet2 = {
    subscriptionId     = "abc"
    VirtualNetworkName = "vnet-security-sea-002"
    address_space      = "10.65.0.0/23"
    sku_name           = "Standard"
    location           = "southeastasia"
  }
}

securitySubnets = {
  Gatewaysubnet = {
    vnet_key               = "vnet1"
    name                   = "gatewaysubnet"
    addressPrefix          = "10.64.0.0/25"
    vnet_name              = "vnet-security-sea-001"
    networkSecurityGroupId = null
    routeTableName         = "rt-security-sea-001-1"
    subscriptionId         = "abc"
  },
  AzureFirewallSubnet = {
    vnet_key               = "vnet1"
    name                   = "AzureFirewallSubnet"
    addressPrefix          = "10.64.0.128/25"
    vnet_name              = "vnet-security-sea-001"
    networkSecurityGroupId = null
    routeTableName         = "rt-security-sea-001-2"
    subscriptionId         = "abc"
  }
}