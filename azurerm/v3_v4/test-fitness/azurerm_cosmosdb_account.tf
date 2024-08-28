resource "azurerm_cosmosdb_account" "db" {
  count = 0

  location                        = azurerm_resource_group.example.location
  name                            = "tfex-cosmos-db-${random_integer.ri.result}"
  offer_type                      = "Standard"
  resource_group_name             = azurerm_resource_group.example.name
  automatic_failover_enabled      = true
  enable_free_tier                = var.azurerm_cosmosdb_account_enable_free_tier
  enable_multiple_write_locations = var.azurerm_cosmosdb_account_enable_multiple_write_locations
  kind                            = "MongoDB"

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
  azurerm_cosmosdb_account_connection_strings              = azurerm_cosmosdb_account.db[0].connection_strings
  azurerm_cosmosdb_account_enable_automatic_failover       = azurerm_cosmosdb_account.db[0].enable_automatic_failover
  azurerm_cosmosdb_account_enable_free_tier                = azurerm_cosmosdb_account.db[0].enable_free_tier
  azurerm_cosmosdb_account_enable_multiple_write_locations = azurerm_cosmosdb_account.db[0].enable_multiple_write_locations
}