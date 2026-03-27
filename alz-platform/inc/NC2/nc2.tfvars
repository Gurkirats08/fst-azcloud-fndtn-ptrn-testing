# global variables
mainLocation = "southeastasia"

# Multiple Resource Groups

nc2resourceGroups = {
  dnsRG = {
    name     = "rg-dns-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  },
  migRG = {
    name     = "rg-mig-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  },
  netRG = {
    name     = "rg-net-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  },
  paasRG = {
    name     = "rg-paas-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  },
  basRG = {
    name     = "rg-bas-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  },
  mgmtRG = {
    name     = "rg-mgmt-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  },
  backupRG = {
    name     = "rg-backup-conn-prd-phi-sea-001"
    location = "southeastasia"
    tags = {}
  }
}

#NSG

nc2NetworkSecurityGroups = {
  nsg-net-phi-conn-eus-001 = {
    resourceGroupName = "rg-net-conn-prd-phi-sea-001"
    name              = "nsg-net-phi-conn-eus-001"
    securityRules = [
      {
        name = "Block-SSH"
        properties = {
          priority                 = 100
          direction                = "Inbound"
          access                   = "Deny"
          protocol                 = "Tcp"
          sourcePortRange          = "*"
          destinationPortRange     = "22"
          sourceAddressPrefix      = "*"
          destinationAddressPrefix = "*"
        }
      }
    ]
  }
  nsg-net-phi-conn-bas-001 = {
    resourceGroupName = "rg-net-conn-prd-phi-sea-001"
    name              = "nsg-net-phi-conn-bas-001"
    securityRules = [
      {
        name = "Allow-HTTPS-Inbound"
        properties = {
          priority                 = 120
          direction                = "Inbound"
          access                   = "Allow"
          protocol                 = "Tcp"
          sourcePortRange          = "*"
          destinationPortRange     = "443"
          sourceAddressPrefix      = "Internet"
          destinationAddressPrefix = "*"
        }
      }
    ]
  }
}

# virtual network
nc2VirtualNetworks = {
  vnet1 = {
    resourceGroupName  = "rg-net-sharedservices-sea-001"
    subscriptionId     = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
    VirtualNetworkName = "vnet-sharedservices-sea-001"
    address_space      = "10.64.0.0/23"
    sku_name           = "Standard"
    location           = "southeastasia"
  }
  vnet2 = {
    resourceGroupName  = "rg-net-sharedservices-sea-001"
    subscriptionId     = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
    VirtualNetworkName = "vnet-sharedservices-sea-002"
    address_space      = "10.65.0.0/23"
    sku_name           = "Standard"
    location           = "southeastasia"
  }
}

nc2Subnets = {
  snet1 = {
    resourceGroupName      = "rg-net-sharedservices-sea-001"
    vnet_key               = "vnet1"
    name                   = "snet1-testing"
    addressPrefix          = "10.64.1.0/25"
    vnet_name              = "vnet-sharedservices-sea-001"
    nsgname                = "nsg-sharedservices-sea-001"
    routeTableName         = null
    subscriptionId         = "3e3a2118-a39a-4ff7-9df7-104c3e1e611a"
  }

   snet2 = {
    resourceGroupName      = "rg-net-sharedservices-sea-001"
    vnet_key               = "vnet2"
    name                   = "snet2-testing"
    addressPrefix          = "10.65.1.0/25"
    vnet_name              = "vnet-sharedservices-sea-002"
    nsgname                = "nsg-sharedservices-sea-002"
    routeTableName         = null
    subscriptionId         = "3e3a2118-a39a-4ff7-9df7-104c3e1e611a"
  }
}


# nc2RouteTables = {
#   rt-net-phi-conn-eus-001-1 = {
#     resourceGroupName         = "rg-net-conn-prd-phi-sea-001"
#     routeTableName            = "rt-net-phi-conn-eus-001-1"
#     enableBgpRoutePropagation = false
#     routes = [{
#       name             = "ksp-pcw-conn-platform-ci-route-01"
#       addressPrefix    = "172.29.0.32/27"
#       NextHopIpAddress = "172.29.0.132"
#       nextHopType      = "VirtualAppliance"
#       },
#       {
#         name             = "ksp-pcw-conn-platform-ci-route-02"
#         addressPrefix    = "172.29.0.128/25"
#         NextHopIpAddress = "172.29.0.132"
#         nextHopType      = "VirtualAppliance"
#       },
#       {
#         name             = "ksp-pcw-conn-platform-ci-route-03"
#         addressPrefix    = "172.29.0.64/26"
#         NextHopIpAddress = "172.29.0.132"
#         nextHopType      = "VirtualAppliance"
#       },
#       {
#         name             = "ksp-pcw-conn-platform-ci-route-04"
#         addressPrefix    = "172.29.1.0/26"
#         NextHopIpAddress = "172.29.0.132"
#         nextHopType      = "VirtualAppliance"
#       }
#     ]
#   }
#   rt-net-phi-conn-eus-001-2 = {
#     resourceGroupName         = "rg-net-conn-prd-phi-sea-001"
#     routeTableName            = "rt-net-phi-conn-eus-001-2"
#     enableBgpRoutePropagation = false
#     routes = [{
#       name          = "ksp-pcw-conn-platform-ci-route-01"
#       addressPrefix = "0.0.0.0/0"
#       nextHopType   = "Internet"
#     }]
#   }
# }

# # Private Endpoint

# connPrivateEndpoint = {
#   "pe1" = {
#     private_endpoint_name          = "pe-phi-conn-eus-001-1"
#     resource_group_name            = "rg-mig-conn-prd-phi-sea-001"
#     location                       = "uaenorth"
#     subnet_id                      = "vnet-net-phi-conn-eus-001_ksp-pcw-conn-platform-ci-vnet-01-snet-01"
#     private_dns_zone_id            = "vaultcore"
#     private_connection_resource_id = "/subscriptions/f8ad85d0-f173-426c-804e-972cc19ea770/resourceGroups/rg-paas-conn-prd-phi-sea-001/providers/Microsoft.Storage/storageAccounts/stgconnphi01"
#     subresource_names              = ["blob"]
#   }
#   #private endpoint for backend storage account
#   "pe2" = {
#     private_endpoint_name          = "pe-phi-conn-sea-001-tfstorage"
#     resource_group_name            = "rg-devops-phi-conn-eus-033"
#     location                       = "uaenorth"
#     private_dns_zone_id            = "vaultcore"
#     subnet_id                      = "vnet-net-phi-conn-eus-001_ksp-pcw-conn-platform-ci-vnet-01-snet-01"
#     private_connection_resource_id = "/subscriptions/f8ad85d0-f173-426c-804e-972cc19ea770/resourceGroups/rg-devops-phi-conn-eus-033/providers/Microsoft.Storage/storageAccounts/stphiconndevopseus033"
#     subresource_names              = ["blob"]
#   }
# }

# nc2ResourceLocks = {
#   "lock1" = {
#     name                = "Lock-paasRG-conn-sea-001"
#     lock_level          = "CanNotDelete"
#     notes               = "Lock to prevent accidental deletion"
#     resource_group_name = "rg-paas-conn-prd-phi-sea-001"
#   }
# }

# diagnostic_logs = {
#   "storage_account_1" = {
#     name                           = "diag-setting-storage1"
#     target_resource_id             = "/subscriptions/f8ad85d0-f173-426c-804e-972cc19ea770/resourceGroups/rg-paas-conn-prd-phi-sea-001/providers/Microsoft.Storage/storageAccounts/stgconnphi01"
#     storage_account_id             = "/subscriptions/f8ad85d0-f173-426c-804e-972cc19ea770/resourceGroups/rg-paas-conn-prd-phi-sea-001/providers/Microsoft.Storage/storageAccounts/stgconnphi01"
#     log_analytics_workspace_id     = "/subscriptions/60115b64-f08a-4207-bb4b-f8eb757aecd1/resourceGroups/rg-mgmt-mgmt-prd-phi-sea-001/providers/Microsoft.OperationalInsights/workspaces/law-phi-mgmt-ops-sea-001"
#     eventhub_name                  = null
#     eventhub_authorization_rule_id = null
#     logs_categories                = []
#     metrics                        = ["AllMetrics"]
#   }
# }







