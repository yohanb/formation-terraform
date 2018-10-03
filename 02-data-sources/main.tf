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

variable "tenant_id" {
}

variable "keyvault_name" {
}

variable "storage_account_name" {
}

provider "azurerm" {
    subscription_id = "${var.subscription_id}"
}

resource "azurerm_resource_group" "main" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "azurerm_key_vault" "kv" {
  name                = "${var.keyvault_name}"
  location            = "${var.location}"
  tenant_id           = "${var.tenant_id}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  sku {
    name = "standard"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

data "azurerm_storage_account" "sa" {
  name                     = "${azurerm_storage_account.sa.name}"
  resource_group_name      = "${azurerm_resource_group.main.name}"
}

resource "azurerm_key_vault_secret" "sa_accountkey" {
  name      = "Azure--Storage--AccountKey"

  #  See https://www.terraform.io/docs/providers/azurerm/d/storage_account.html
  value     = "${data.azurerm_storage_account.sa.primary_access_key}"
  vault_uri = "${azurerm_key_vault.kv.vault_uri}"
}