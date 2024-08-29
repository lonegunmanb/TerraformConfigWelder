resource "azurerm_kubernetes_cluster" "example" {
  count = 1

  location                        = azurerm_resource_group.example.location
  name                            = "example-aks1"
  resource_group_name             = azurerm_resource_group.example.name
  api_server_authorized_ip_ranges = ["198.51.100.0/24"]
  automatic_channel_upgrade       = var.azurerm_kubernetes_cluster_automatic_channel_upgrade
  dns_prefix                      = "exampleaks1"
  enable_pod_security_policy      = var.azurerm_kubernetes_cluster_enable_pod_security_policy
  node_os_channel_upgrade         = var.azurerm_kubernetes_cluster_node_os_channel_upgrade
  public_network_access_enabled   = var.azurerm_kubernetes_cluster_public_network_access_enabled
  tags = {
    Environment = "Production"
  }

  default_node_pool {
    name                   = "default"
    vm_size                = "Standard_D2_v2"
    enable_auto_scaling    = var.azure_kubernetes_cluster_default_node_pool_enable_auto_scaling
    enable_host_encryption = var.azure_kubernetes_cluster_default_node_pool_enable_host_encryption
    enable_node_public_ip  = var.azure_kubernetes_cluster_default_node_pool_enable_node_public_ip
    node_count             = 1
    node_taints            = var.azure_kubernetes_cluster_default_node_pool_node_taints

    linux_os_config {
      swap_file_size_mb = 100
    }
  }
  azure_active_directory_role_based_access_control {
    client_app_id     = var.azure_kubernetes_cluster_azure_active_directory_role_based_access_control_client_app_id
    managed           = var.azure_kubernetes_cluster_azure_active_directory_role_based_access_control_managed
    server_app_id     = var.azure_kubernetes_cluster_azure_active_directory_role_based_access_control_server_app_id
    server_app_secret = var.azure_kubernetes_cluster_azure_active_directory_role_based_access_control_server_app_secret
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin     = "azure"
    docker_bridge_cidr = var.azure_kubernetes_cluster_network_profile_docker_bridge_cidr
    ebpf_data_plane    = "azure"
  }
  web_app_routing {
    dns_zone_id = var.azure_kubernetes_cluster_web_app_routing_dns_zone_id
  }
  workload_autoscaler_profile {
    vertical_pod_autoscaler_controlled_values = var.azure_kubernetes_cluster_workload_autoscaler_profile_vertical_pod_autoscaler_controlled_values
    vertical_pod_autoscaler_update_mode       = var.azure_kubernetes_cluster_workload_autoscaler_profile_vertical_pod_autoscaler_update_mode
  }
}

locals {
  azurerm_kubernetes_clusetr_web_app_routing_dns_zone_id              = azurerm_kubernetes_cluster.example[0].web_app_routing[0].dns_zone_id
  azurerm_kubernetes_clusetr_web_app_routing_dns_zone_ids             = azurerm_kubernetes_cluster.example[0].web_app_routing[0].dns_zone_ids
  azurerm_kubernetes_cluster_api_server_authorized_ip_ranges          = azurerm_kubernetes_cluster.example[0].api_server_authorized_ip_ranges
  azurerm_kubernetes_cluster_automatic_channel_upgrade                = azurerm_kubernetes_cluster.example[0].automatic_channel_upgrade
  azurerm_kubernetes_cluster_default_node_pool_enable_auto_scaling    = azurerm_kubernetes_cluster.example[0].default_node_pool[0].enable_auto_scaling
  azurerm_kubernetes_cluster_default_node_pool_enable_host_encryption = azurerm_kubernetes_cluster.example[0].default_node_pool[0].enable_host_encryption
  azurerm_kubernetes_cluster_default_node_pool_enable_node_public_ip  = azurerm_kubernetes_cluster.example[0].default_node_pool[0].enable_node_public_ip
  azurerm_kubernetes_cluster_ebpf_data_plane                          = one(azurerm_kubernetes_cluster.example[0].network_profile.*.ebpf_data_plane)
  azurerm_kubernetes_cluster_node_os_channel_upgrade                  = azurerm_kubernetes_cluster.example[0].node_os_channel_upgrade
  azurerm_kubernetes_cluster_swap_file_size_mb                        = azurerm_kubernetes_cluster.example[0].default_node_pool[0].linux_os_config[0].swap_file_size_mb
}