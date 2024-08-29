resource "azurerm_cosmosdb_sql_container" "example" {
  account_name          = data.azurerm_cosmosdb_account.example.name
  database_name         = azurerm_cosmosdb_sql_database.example.name
  name                  = "example-container"
  resource_group_name   = data.azurerm_cosmosdb_account.example.resource_group_name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    excluded_path {
      path = "/excluded/?"
    }
    included_path {
      path = "/*"
    }
    included_path {
      path = "/included/?"
    }
  }
  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}

locals {
  another_azurerm_cosmosdb_sql_container_partition_key_paths = azurerm_cosmosdb_sql_container.example.partition_key_paths
  azurerm_cosmosdb_sql_container_partition_key_path          = azurerm_cosmosdb_sql_container.example.partition_key_paths[0]
}