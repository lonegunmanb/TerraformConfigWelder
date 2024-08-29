resource "azurerm_kubernetes_cluster_node_pool" "example" {
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.example.id
  name                   = "internal"
  vm_size                = "Standard_DS2_v2"
  enable_auto_scaling    = var.azurerm_kubernetes_cluster_node_pool_enable_auto_scaling
  enable_host_encryption = var.azurerm_kubernetes_cluster_node_pool_enable_host_encryption
  enable_node_public_ip  = var.azurerm_kubernetes_cluster_node_pool_enable_node_public_ip
  node_count             = 1
  tags = {
    Environment = "Production"
  }
}

locals {
  azurerm_kubernetes_cluster_node_pool_enable_auto_scaling    = azurerm_kubernetes_cluster_node_pool.example.enable_auto_scaling
  azurerm_kubernetes_cluster_node_pool_enable_host_encryption = azurerm_kubernetes_cluster_node_pool.example.enable_host_encryption
  azurerm_kubernetes_cluster_node_pool_enable_node_public_ip  = azurerm_kubernetes_cluster_node_pool.example.enable_node_public_ip
}