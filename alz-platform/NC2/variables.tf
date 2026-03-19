# Global Variables
variable "mainLocation" {
  type        = string
  description = "Main location for resources"
}

variable "nc2resourceGroups" {
  description = "Resource groups"
  type = map(object({
    name     = string
    tags     = optional(map(string))
  }))
  default = {}
}

variable "nc2NetworkSecurityGroups" {
  type = map(object({
    name              = string
    tags              = optional(map(string))
    resourceGroupName = string
    securityRules = list(object({
      name        = string
      description = optional(string)
      properties = object({
        protocol                                 = string
        direction                                = string
        access                                   = string
        priority                                 = number
        sourceAddressPrefix                      = optional(string)
        sourceAddressPrefixes                    = optional(list(string))
        destinationAddressPrefix                 = optional(string)
        destinationAddressPrefixes               = optional(list(string))
        sourcePortRange                          = optional(string)
        sourcePortRanges                         = optional(list(string))
        destinationPortRange                     = optional(string)
        destinationPortRanges                    = optional(list(string))
        sourceApplicationSecurityGroupNames      = optional(list(string))
        destinationApplicationSecurityGroupNames = optional(list(string))
      })
    }))
  }))
  description = "The network security groups with their properties."
  default     = {}
}

variable "nc2VirtualNetworks" {
  description = "Virtual networks"
  type = map(object({
    resourceGroupName  = string
    VirtualNetworkName = string
    address_space      = string
    sku_name           = string
  }))
  default = {}
}

variable "nc2Subnets" {
  description = "The subnets with their properties."
  type = map(object({
    resourceGroupName      = string
    vnet_key               = string
    name                   = string
    addressPrefix          = string
    vnet_name              = string
    nsgName                = optional(string)
    routeTableName         = optional(string)
    subscriptionId         = optional(string)
  }))
  default = {}
}

variable "nc2RouteTables" {
  type = map(object({
    resourceGroupName         = string
    routeTableName            = string
    enableBgpRoutePropagation = bool
    routes = list(object({
      name             = string
      addressPrefix    = string
      nextHopType      = string
      NextHopIpAddress = optional(string)
    }))
  }))
  description = "The route tables with their properties."
  default     = {}
}

# variable "nc2PrivateEndpoint" {
#   type = map(object({
#     private_endpoint_name          = string
#     resource_group_name            = string
#     location                       = string
#     subnet_id                      = string
#     private_dns_zone_id            = string
#     private_connection_resource_id = string
#     subresource_names              = list(string)
#   }))
# }

# variable "nc2ResourceLocks" {
#   description = "Resource Locks"
#   type = map(object({
#     resource_name       = optional(string)
#     name                = string
#     lock_level          = string
#     notes               = string
#     resource_type       = optional(string)
#     resource_group_name = string
#   }))
#   default = {}

# }

# variable "diagnostic_logs" {
#   description = "Map of resources (storage accounts, SQL PaaS, etc.) with diagnostic settings configuration."
#   type = map(object({
#     name                           = string
#     target_resource_id             = string
#     storage_account_id             = string
#     log_analytics_workspace_id     = string
#     eventhub_name                  = string
#     eventhub_authorization_rule_id = string
#     logs_categories                = list(string)
#     metrics                        = list(string)
#   }))
# }


