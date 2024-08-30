resource "azurerm_redis_enterprise_database" "example" {
  cluster_id                     = azurerm_redis_enterprise_cluster.example.id
  client_protocol                = "Encrypted"
  clustering_policy              = "EnterpriseCluster"
  eviction_policy                = "NoEviction"
  linked_database_group_nickname = "tftestGeoGroup"
  linked_database_id = [
    "${azurerm_redis_enterprise_cluster.example.id}/databases/default",
    "${azurerm_redis_enterprise_cluster.example1.id}/databases/default"
  ]
  name                = "default"
  port                = 10000
  resource_group_name = var.azurerm_redis_enterprise_database_resource_group_name
}