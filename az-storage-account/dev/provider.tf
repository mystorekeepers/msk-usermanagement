
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "msk-configurations-rg"
    storage_account_name = "mskconfigurations48"
    container_name       = "az-storage-account"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.msk-subscription
}
