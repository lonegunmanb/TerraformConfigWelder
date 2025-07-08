data "azurerm_kubernetes_cluster" "example" {
  name                = "myakscluster"
  resource_group_name = "my-example-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_auto_scaling    = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].auto_scaling_enabled
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_host_encryption = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].host_encryption_enabled
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_node_public_ip  = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].node_public_ip_enabled
}