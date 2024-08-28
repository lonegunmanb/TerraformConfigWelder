resource "azurerm_cosmosdb_account" "db" {
  count = 0

  location                         = azurerm_resource_group.example.location
  name                             = "tfex-cosmos-db-${random_integer.ri.result}"
  offer_type                       = "Standard"
  resource_group_name              = azurerm_resource_group.example.name
  automatic_failover_enabled       = true
  free_tier_enabled                = var.azurerm_cosmosdb_account_enable_free_tier
  kind                             = "MongoDB"
  multiple_write_locations_enabled = var.azurerm_cosmosdb_account_enable_multiple_write_locations

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  geo_location {
    failover_priority = 1
    location          = "eastus"
  }
  geo_location {
    failover_priority = 0
    location          = "westus"
  }
  capabilities {
    name = "EnableAggregationPipeline"
  }
  capabilities {
    name = "mongoEnableDocLevelTTL"
  }
  capabilities {
    name = "MongoDBv3.4"
  }
  capabilities {
    name = "EnableMongo"
  }
}

locals {
  azurerm_cosmosdb_account_connection_strings              = compact([try(azurerm_cosmosdb_account.db[0].primary_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].primary_readonly_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_readonly_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].primary_mongodb_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_mongodb_connection_string, ""), try(azurerm_cosmosdb_account.db[0].primary_readonly_mongodb_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_readonly_mongodb_connection_string, "")])
  azurerm_cosmosdb_account_enable_automatic_failover       = azurerm_cosmosdb_account.db[0].automatic_failover_enabled
  azurerm_cosmosdb_account_enable_free_tier                = azurerm_cosmosdb_account.db[0].free_tier_enabled
  azurerm_cosmosdb_account_enable_multiple_write_locations = azurerm_cosmosdb_account.db[0].multiple_write_locations_enabled
}