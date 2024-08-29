resource "azurerm_kubernetes_cluster_node_pool" "example" {
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.example.id
  name                    = "internal"
  vm_size                 = "Standard_DS2_v2"
  auto_scaling_enabled    = var.azurerm_kubernetes_cluster_node_pool_enable_auto_scaling
  host_encryption_enabled = var.azurerm_kubernetes_cluster_node_pool_enable_host_encryption
  node_count              = 1
  node_public_ip_enabled  = var.azurerm_kubernetes_cluster_node_pool_enable_node_public_ip
  tags = {
    Environment = "Production"
  }
}

locals {
  azurerm_kubernetes_cluster_node_pool_enable_auto_scaling    = azurerm_kubernetes_cluster_node_pool.example.auto_scaling_enabled
  azurerm_kubernetes_cluster_node_pool_enable_host_encryption = azurerm_kubernetes_cluster_node_pool.example.host_encryption_enabled
  azurerm_kubernetes_cluster_node_pool_enable_node_public_ip  = azurerm_kubernetes_cluster_node_pool.example.node_public_ip_enabled
}