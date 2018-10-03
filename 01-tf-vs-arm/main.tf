variable "subscription_id" {
  description = "The Azure subscription id"
}
variable "location" {
  description = "The location where the resources will be provisioned. This needs to be the same as where the image exists."
  default     = "Canada East"
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the resources."
}

provider "azurerm" {
    subscription_id = "${var.subscription_id}"
}

resource "azurerm_resource_group" "main" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
  }
}