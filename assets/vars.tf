
## *.tf ##

# Definition
variable "location" {
  description = "The location where the resources will be provisioned."
  default     = "Canada East"
}

# Usage
resource "azurerm_resource_group" "main" {
    location = "${var.location}"
}

## *.tfvars (or *.auto.tfvars) ##
# Assignment
location = "East US 2"
