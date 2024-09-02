data "azurerm_cosmosdb_account" "example" {
  name                = "tfex-cosmosdb-account"
  resource_group_name = "tfex-cosmosdb-account-rg"
}

locals {
  data_azurerm_cosmosdb_account_connection_strings              = data.azurerm_cosmosdb_account.example.connection_strings
  data_azurerm_cosmosdb_account_enable_automatic_failover       = data.azurerm_cosmosdb_account.example.enable_automatic_failover
  data_azurerm_cosmosdb_account_enable_free_tier                = data.azurerm_cosmosdb_account.example.enable_free_tier
  data_azurerm_cosmosdb_account_enable_multiple_write_locations = data.azurerm_cosmosdb_account.example.enable_multiple_write_locations
}