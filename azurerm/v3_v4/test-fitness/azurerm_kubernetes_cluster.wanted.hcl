resource "azurerm_kubernetes_cluster" "example" {
  count = 1

  location                  = azurerm_resource_group.example.location
  name                      = "example-aks1"
  resource_group_name       = azurerm_resource_group.example.name
  automatic_upgrade_channel = var.azurerm_kubernetes_cluster_automatic_channel_upgrade
  dns_prefix                = "exampleaks1"
  node_os_upgrade_channel   = var.azurerm_kubernetes_cluster_node_os_channel_upgrade
  tags = {
    Environment = "Production"
  }

  default_node_pool {
    name                    = "default"
    vm_size                 = "Standard_D2_v2"
    auto_scaling_enabled    = var.azure_kubernetes_cluster_default_node_pool_enable_auto_scaling
    host_encryption_enabled = var.azure_kubernetes_cluster_default_node_pool_enable_host_encryption
    node_count              = 1
    node_public_ip_enabled  = var.azure_kubernetes_cluster_default_node_pool_enable_node_public_ip

    linux_os_config {
      swap_file_size_mb = 100
    }
  }
  api_server_access_profile {
    authorized_ip_ranges = ["198.51.100.0/24"]
  }
  azure_active_directory_role_based_access_control {}
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin     = "azure"
    network_data_plane = "azure"
  }
  web_app_routing {
    dns_zone_ids = [var.azure_kubernetes_cluster_web_app_routing_dns_zone_id]
  }
  workload_autoscaler_profile {}

  lifecycle {
    ignore_changes = [api_server_access_profile, network_profile[0].load_balancer_profile[0].outbound_ip_address_ids, network_profile[0].load_balancer_profile[0].outbound_ip_prefix_ids]
  }
}

locals {
  azurerm_kubernetes_clusetr_web_app_routing_dns_zone_id              = azurerm_kubernetes_cluster.example[0].web_app_routing[0].dns_zone_ids[0]
  azurerm_kubernetes_clusetr_web_app_routing_dns_zone_ids             = azurerm_kubernetes_cluster.example[0].web_app_routing[0].dns_zone_ids
  azurerm_kubernetes_cluster_api_server_authorized_ip_ranges          = azurerm_kubernetes_cluster.example[0].api_server_access_profile[0].authorized_ip_ranges
  azurerm_kubernetes_cluster_automatic_channel_upgrade                = azurerm_kubernetes_cluster.example[0].automatic_upgrade_channel
  azurerm_kubernetes_cluster_default_node_pool_enable_auto_scaling    = azurerm_kubernetes_cluster.example[0].default_node_pool[0].auto_scaling_enabled
  azurerm_kubernetes_cluster_default_node_pool_enable_host_encryption = azurerm_kubernetes_cluster.example[0].default_node_pool[0].host_encryption_enabled
  azurerm_kubernetes_cluster_default_node_pool_enable_node_public_ip  = azurerm_kubernetes_cluster.example[0].default_node_pool[0].node_public_ip_enabled
  azurerm_kubernetes_cluster_ebpf_data_plane                          = one(azurerm_kubernetes_cluster.example[0].network_profile.*.network_data_plane)
  azurerm_kubernetes_cluster_node_os_channel_upgrade                  = azurerm_kubernetes_cluster.example[0].node_os_upgrade_channel
  azurerm_kubernetes_cluster_swap_file_size_mb                        = azurerm_kubernetes_cluster.example[0].default_node_pool[0].linux_os_config[0].swap_file_size_mb
}