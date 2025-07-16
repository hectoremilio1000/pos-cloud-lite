#/Users/hectoremilio/Proyectos/growthsuitecompleto/Backend/pos-cloud-lite/00-providers.tf
terraform {
  required_version = "~> 1.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.117.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "azurerm" {
  features {}
}
