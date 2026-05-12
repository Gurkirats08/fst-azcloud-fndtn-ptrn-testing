# Global Variables
variable "environment" {
  type        = string
  description = "Environment type"
}

variable "mainLocation" {
  type        = string
  description = "Resource Location"
}

// variable "storageAccountName"{
//   type = string
//   description = "storage for diagnostics"
// }

// variable "storageAccountResourceGroupName"{
//   type = string
//   description = "storage for diagnostics"
// }

variable "tags" {
  type    = map(string)
  default = {}
}

# variable "backupVaultName" {
#   type        = string
#   description = "Backup Vault Name"

# }

#uan
variable "communicationuan" {
  type        = string
  description = "user assigned identity"
}

variable "subscriptionId" {
  type        = string
  description = "communication sub ID"
}

variable "github_pat" {
  type        = string
  description = "GitHub Personal Access Token for private module access"
  sensitive   = true
}

# Resource Group
variable "resourceGroups" {
  description = "Resource groups"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
  default = {}
}


# storage account
variable "storageAccounts" {
  description = "Storage Accounts"
  type = map(object({
    name                      = string
    account_tier              = string
    account_replication_type  = string
    resource_group_name       = string
    location                  = string
    shared_access_key_enabled = optional(bool)

  }))
  default = {}
}
variable "network_watcher_name" {
  description = "Network Watcher Name"
  type        = string
}

variable "network_watcher_rg" {
  description = "Network Watcher Resource Group"
  type        = string
}

# Virtual Network
variable "communicationVirtualNetworks" {
  description = "Virtual networks"
  type = map(object({
    subscriptionId     = string
    VirtualNetworkName = string
    address_space      = string
    sku_name           = string

  }))
  default = {}
}

#subnets
variable "communicationSubnets" {
  description = "The subnets with their properties."
  type = map(object({
    vnet_key               = string
    name                   = string
    addressPrefix          = string
    vnet_name              = string
    networkSecurityGroupId = optional(string)
    routeTableName         = optional(string)
    subscriptionId         = optional(string)
  }))
  default = {}
}

# Virtual Hub
variable "communicationVHub" {
  description = "Virtual Hubs"
  type = map(object({
    name                   = string
    location               = string
    vwan_key               = string
    address_prefix         = string
    create_firewall_policy = optional(bool)
    firewall_policy_id     = optional(string)
    vnet_connections       = optional(map(object({
      vnet_key = string
    })))
  }))
  default = {}
}

# Virtual WAN
variable "communicationVWAN" {
  description = "Virtual WANs"
  type = map(object({
    name     = string
    location = string
  }))
  default = {}
}

# Route Tables
variable "communicationRouteTables" {
  description = "Route Tables"
  type = map(object({
    resourceGroupName          = string
    routeTableName             = string
    enableBgpRoutePropagation  = bool
    routes                     = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    }))
  }))
  default = {}
}