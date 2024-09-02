data "azurerm_cosmosdb_account" "example" {
  name                = "tfex-cosmosdb-account"
  resource_group_name = "tfex-cosmosdb-account-rg"
}

locals {
  data_azurerm_cosmosdb_account_connection_strings              = compact([try(data.azurerm_cosmosdb_account.example.primary_sql_connection_string, ""), try(data.azurerm_cosmosdb_account.example.secondary_sql_connection_string, ""), try(data.azurerm_cosmosdb_account.example.primary_readonly_sql_connection_string, ""), try(data.azurerm_cosmosdb_account.example.secondary_readonly_sql_connection_string, ""), try(data.azurerm_cosmosdb_account.example.primary_mongodb_connection_string, ""), try(data.azurerm_cosmosdb_account.example.secondary_mongodb_connection_string, ""), try(data.azurerm_cosmosdb_account.example.primary_readonly_mongodb_connection_string, ""), try(data.azurerm_cosmosdb_account.example.secondary_readonly_mongodb_connection_string, "")])
  data_azurerm_cosmosdb_account_enable_automatic_failover       = data.azurerm_cosmosdb_account.example.automatic_failover_enabled
  data_azurerm_cosmosdb_account_enable_free_tier                = data.azurerm_cosmosdb_account.example.free_tier_enabled
  data_azurerm_cosmosdb_account_enable_multiple_write_locations = data.azurerm_cosmosdb_account.example.multiple_write_locations_enabled
}