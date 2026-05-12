terraform {
  
  required_version = ">= 0.15"
  //required_version = ">=1.3.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1" 
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.13.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"  
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.1"
    }
  }
  backend "azurerm" {}
}

provider "null" {
//  source  = "hashicorp/null"
}
  
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "xyz"
  resource_provider_registrations = "all"
  storage_use_azuread = true
}


# provider "azurerm" {
#   alias = "communicationSub"
#   features {
#     resource_group {
#       prevent_deletion_if_contains_resources = true
#     }
#   }
#   # skip_provider_registration = true
#   storage_use_azuread = true
# }