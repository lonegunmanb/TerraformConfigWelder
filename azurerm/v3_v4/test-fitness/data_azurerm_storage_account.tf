data "azurerm_storage_account" "example" {
  name                = "packerimages"
  resource_group_name = "packer-storage"
}

locals {
  data_azurerm_storage_account_enable_https_traffic_only = data.azurerm_storage_account.example.enable_https_traffic_only
}