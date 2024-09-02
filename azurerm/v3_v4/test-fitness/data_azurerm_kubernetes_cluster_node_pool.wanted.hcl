data "azurerm_kubernetes_cluster_node_pool" "example" {
  kubernetes_cluster_name = "existing-cluster"
  name                    = "existing"
  resource_group_name     = "existing-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_node_pool_enable_auto_scaling   = data.azurerm_kubernetes_cluster_node_pool.example.auto_scaling_enabled
  data_azurerm_kubernetes_cluster_node_pool_enable_node_public_ip = data.azurerm_kubernetes_cluster_node_pool.example.node_public_ip_enabled
}