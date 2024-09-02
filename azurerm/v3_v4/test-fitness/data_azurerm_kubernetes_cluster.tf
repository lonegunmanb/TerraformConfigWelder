data "azurerm_kubernetes_cluster" "example" {
  name                = "myakscluster"
  resource_group_name = "my-example-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_auto_scaling    = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_auto_scaling
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_host_encryption = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_host_encryption
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_node_public_ip  = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_node_public_ip
}