provider "azurerm" {
  features {}
}


data "azurerm_cosmosdb_account" "example" {
  name                = "tfex-cosmosdb-account"
  resource_group_name = "tfex-cosmosdb-account-rg"
}

locals {
  data_azurerm_cosmosdb_account_connection_strings              = data.azurerm_cosmosdb_account.example.connection_strings
  data_azurerm_cosmosdb_account_enable_multiple_write_locations = data.azurerm_cosmosdb_account.example.enable_multiple_write_locations
}

data "azurerm_kubernetes_cluster" "example" {
  name                = "myakscluster"
  resource_group_name = "my-example-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_auto_scaling    = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_auto_scaling
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_host_encryption = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_host_encryption
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_node_public_ip  = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_node_public_ip
}

data "azurerm_kubernetes_cluster_node_pool" "example" {
  kubernetes_cluster_name = "existing-cluster"
  name                    = "existing"
  resource_group_name     = "existing-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_node_pool_enable_auto_scaling   = data.azurerm_kubernetes_cluster_node_pool.example.enable_auto_scaling
  data_azurerm_kubernetes_cluster_node_pool_enable_node_public_ip = data.azurerm_kubernetes_cluster_node_pool.example.enable_node_public_ip
}

data "azurerm_monitor_diagnostic_categories" "example" {
  resource_id = data.azurerm_key_vault.example.id
}

locals {
  data_azurerm_monitor_diagnostic_logs = data.azurerm_monitor_diagnostic_categories.example.logs
}

data "azurerm_network_interface" "example" {
  name                = "acctest-nic"
  resource_group_name = "networking"
}

locals {
  data_azurerm_network_interface_enable_accelerated_networking = data.azurerm_network_interface.example.enable_accelerated_networking
  data_azurerm_network_interface_enable_ip_forwarding          = data.azurerm_network_interface.example.enable_ip_forwarding
}

data "azurerm_storage_table_entity" "example" {
  partition_key    = "example-partition-key"
  row_key          = "example-row-key"
  storage_table_id = "https://example.table.core.windows.net/table1(PartitionKey='samplepartition',RowKey='samplerow')"
}

locals {
  data_azurerm_storage_table_entity_storage_account_name = data.azurerm_storage_table_entity.example.storage_account_name
  data_azurerm_storage_table_entity_table_name           = data.azurerm_storage_table_entity.example.table_name
}