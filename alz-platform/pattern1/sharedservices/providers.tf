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
  version = "~> 3.1"
}
  
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
  skip_provider_registration = true
  storage_use_azuread = true
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
  skip_provider_registration = true
  storage_use_azuread = true
  alias = "sharedSub"
}
provider "azurerm" {
  alias = "securitySub"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  # skip_provider_registration = true
  storage_use_azuread = true
  subscription_id = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
}

provider "azurerm" {
  alias = "connSub"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  storage_use_azuread = true
  subscription_id     = "0e587ef7-4069-4a5c-ab6e-2132c83dfbf1"
}