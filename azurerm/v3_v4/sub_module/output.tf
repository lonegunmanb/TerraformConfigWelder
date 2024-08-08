output "ebpf_data_plane" {
  value = try(azurerm_kubernetes_cluster.this.network_profile[0].ebpf_data_plane, null)
}