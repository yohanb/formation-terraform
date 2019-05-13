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

module "network-security-group" {
    source                     = "Azure/network-security-group/azurerm"
    resource_group_name        = "${var.resource_group_name}"
    location                   = "${var.location}"
    security_group_name        = "nsg"
}
  
resource "null_resource" "example" {}
