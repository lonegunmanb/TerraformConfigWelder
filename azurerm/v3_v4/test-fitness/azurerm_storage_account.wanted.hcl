resource "azurerm_storage_account" "example" {
  account_replication_type   = "GRS"
  account_tier               = "Standard"
  location                   = azurerm_resource_group.example.location
  name                       = "storageaccountname"
  resource_group_name        = azurerm_resource_group.example.name
  https_traffic_only_enabled = var.azurerm_storage_account_enable_https_traffic_only
  tags = {
    environment = "staging"
  }
}

locals {
  azurerm_storage_account_enable_https_traffic_only = azurerm_storage_account.example.https_traffic_only_enabled
}