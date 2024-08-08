resource "azurerm_kubernetes_cluster" "this" {
  location                            = var.kubernetes_cluster_location
  name                                = var.kubernetes_cluster_name
  resource_group_name                 = var.kubernetes_cluster_resource_group_name
#   api_server_authorized_ip_ranges     = var.kubernetes_cluster_api_server_authorized_ip_ranges
  automatic_channel_upgrade           = var.kubernetes_cluster_automatic_channel_upgrade
  azure_policy_enabled                = var.kubernetes_cluster_azure_policy_enabled
  cost_analysis_enabled               = var.kubernetes_cluster_cost_analysis_enabled
  custom_ca_trust_certificates_base64 = var.kubernetes_cluster_custom_ca_trust_certificates_base64
  disk_encryption_set_id              = var.kubernetes_cluster_disk_encryption_set_id
  dns_prefix                          = var.kubernetes_cluster_dns_prefix
  dns_prefix_private_cluster          = var.kubernetes_cluster_dns_prefix_private_cluster
  edge_zone                           = var.kubernetes_cluster_edge_zone
  enable_pod_security_policy          = var.kubernetes_cluster_enable_pod_security_policy
  http_application_routing_enabled    = var.kubernetes_cluster_http_application_routing_enabled
  image_cleaner_enabled               = var.kubernetes_cluster_image_cleaner_enabled
  image_cleaner_interval_hours        = var.kubernetes_cluster_image_cleaner_interval_hours
  kubernetes_version                  = var.kubernetes_cluster_kubernetes_version
  local_account_disabled              = var.kubernetes_cluster_local_account_disabled
  node_os_channel_upgrade             = var.kubernetes_cluster_node_os_channel_upgrade
  node_resource_group                 = var.kubernetes_cluster_node_resource_group
  oidc_issuer_enabled                 = var.kubernetes_cluster_oidc_issuer_enabled
  open_service_mesh_enabled           = var.kubernetes_cluster_open_service_mesh_enabled
  private_cluster_enabled             = var.kubernetes_cluster_private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.kubernetes_cluster_private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.kubernetes_cluster_private_dns_zone_id
  public_network_access_enabled       = var.kubernetes_cluster_public_network_access_enabled
  role_based_access_control_enabled   = var.kubernetes_cluster_role_based_access_control_enabled
  run_command_enabled                 = var.kubernetes_cluster_run_command_enabled
  sku_tier                            = var.kubernetes_cluster_sku_tier
  support_plan                        = var.kubernetes_cluster_support_plan
  tags                                = var.kubernetes_cluster_tags
  workload_identity_enabled           = var.kubernetes_cluster_workload_identity_enabled

  dynamic "default_node_pool" {
    for_each = [var.kubernetes_cluster_default_node_pool]
    content {
      name                          = default_node_pool.value.name
      vm_size                       = default_node_pool.value.vm_size
      capacity_reservation_group_id = default_node_pool.value.capacity_reservation_group_id
      custom_ca_trust_enabled       = default_node_pool.value.custom_ca_trust_enabled
      enable_auto_scaling           = default_node_pool.value.enable_auto_scaling
      enable_host_encryption        = default_node_pool.value.enable_host_encryption
      enable_node_public_ip         = default_node_pool.value.enable_node_public_ip
      fips_enabled                  = default_node_pool.value.fips_enabled
      gpu_instance                  = default_node_pool.value.gpu_instance
      host_group_id                 = default_node_pool.value.host_group_id
      kubelet_disk_type             = default_node_pool.value.kubelet_disk_type
      max_count                     = default_node_pool.value.max_count
      max_pods                      = default_node_pool.value.max_pods
      message_of_the_day            = default_node_pool.value.message_of_the_day
      min_count                     = default_node_pool.value.min_count
      node_count                    = default_node_pool.value.node_count
      node_labels                   = default_node_pool.value.node_labels
      node_public_ip_prefix_id      = default_node_pool.value.node_public_ip_prefix_id
      node_taints                   = default_node_pool.value.node_taints
      only_critical_addons_enabled  = default_node_pool.value.only_critical_addons_enabled
      orchestrator_version          = default_node_pool.value.orchestrator_version
      os_disk_size_gb               = default_node_pool.value.os_disk_size_gb
      os_disk_type                  = default_node_pool.value.os_disk_type
      os_sku                        = default_node_pool.value.os_sku
      pod_subnet_id                 = default_node_pool.value.pod_subnet_id
      proximity_placement_group_id  = default_node_pool.value.proximity_placement_group_id
      scale_down_mode               = default_node_pool.value.scale_down_mode
      snapshot_id                   = default_node_pool.value.snapshot_id
      tags                          = default_node_pool.value.tags
      temporary_name_for_rotation   = default_node_pool.value.temporary_name_for_rotation
      type                          = default_node_pool.value.type
      ultra_ssd_enabled             = default_node_pool.value.ultra_ssd_enabled
      vnet_subnet_id                = default_node_pool.value.vnet_subnet_id
      workload_runtime              = default_node_pool.value.workload_runtime
      zones                         = default_node_pool.value.zones

      dynamic "kubelet_config" {
        for_each = default_node_pool.value.kubelet_config == null ? [] : [default_node_pool.value.kubelet_config]
        content {
          allowed_unsafe_sysctls    = kubelet_config.value.allowed_unsafe_sysctls
          container_log_max_line    = kubelet_config.value.container_log_max_line
          container_log_max_size_mb = kubelet_config.value.container_log_max_size_mb
          cpu_cfs_quota_enabled     = kubelet_config.value.cpu_cfs_quota_enabled
          cpu_cfs_quota_period      = kubelet_config.value.cpu_cfs_quota_period
          cpu_manager_policy        = kubelet_config.value.cpu_manager_policy
          image_gc_high_threshold   = kubelet_config.value.image_gc_high_threshold
          image_gc_low_threshold    = kubelet_config.value.image_gc_low_threshold
          pod_max_pid               = kubelet_config.value.pod_max_pid
          topology_manager_policy   = kubelet_config.value.topology_manager_policy
        }
      }
      dynamic "linux_os_config" {
        for_each = default_node_pool.value.linux_os_config == null ? [] : [default_node_pool.value.linux_os_config]
        content {
          swap_file_size_mb             = linux_os_config.value.swap_file_size_mb
          transparent_huge_page_defrag  = linux_os_config.value.transparent_huge_page_defrag
          transparent_huge_page_enabled = linux_os_config.value.transparent_huge_page_enabled

          dynamic "sysctl_config" {
            for_each = linux_os_config.value.sysctl_config == null ? [] : [linux_os_config.value.sysctl_config]
            content {
              fs_aio_max_nr                      = sysctl_config.value.fs_aio_max_nr
              fs_file_max                        = sysctl_config.value.fs_file_max
              fs_inotify_max_user_watches        = sysctl_config.value.fs_inotify_max_user_watches
              fs_nr_open                         = sysctl_config.value.fs_nr_open
              kernel_threads_max                 = sysctl_config.value.kernel_threads_max
              net_core_netdev_max_backlog        = sysctl_config.value.net_core_netdev_max_backlog
              net_core_optmem_max                = sysctl_config.value.net_core_optmem_max
              net_core_rmem_default              = sysctl_config.value.net_core_rmem_default
              net_core_rmem_max                  = sysctl_config.value.net_core_rmem_max
              net_core_somaxconn                 = sysctl_config.value.net_core_somaxconn
              net_core_wmem_default              = sysctl_config.value.net_core_wmem_default
              net_core_wmem_max                  = sysctl_config.value.net_core_wmem_max
              net_ipv4_ip_local_port_range_max   = sysctl_config.value.net_ipv4_ip_local_port_range_max
              net_ipv4_ip_local_port_range_min   = sysctl_config.value.net_ipv4_ip_local_port_range_min
              net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh1
              net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh2
              net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh3
              net_ipv4_tcp_fin_timeout           = sysctl_config.value.net_ipv4_tcp_fin_timeout
              net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.net_ipv4_tcp_keepalive_intvl
              net_ipv4_tcp_keepalive_probes      = sysctl_config.value.net_ipv4_tcp_keepalive_probes
              net_ipv4_tcp_keepalive_time        = sysctl_config.value.net_ipv4_tcp_keepalive_time
              net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.net_ipv4_tcp_max_syn_backlog
              net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.net_ipv4_tcp_max_tw_buckets
              net_ipv4_tcp_tw_reuse              = sysctl_config.value.net_ipv4_tcp_tw_reuse
              net_netfilter_nf_conntrack_buckets = sysctl_config.value.net_netfilter_nf_conntrack_buckets
              net_netfilter_nf_conntrack_max     = sysctl_config.value.net_netfilter_nf_conntrack_max
              vm_max_map_count                   = sysctl_config.value.vm_max_map_count
              vm_swappiness                      = sysctl_config.value.vm_swappiness
              vm_vfs_cache_pressure              = sysctl_config.value.vm_vfs_cache_pressure
            }
          }
        }
      }
      dynamic "node_network_profile" {
        for_each = default_node_pool.value.node_network_profile == null ? [] : [default_node_pool.value.node_network_profile]
        content {
          application_security_group_ids = node_network_profile.value.application_security_group_ids
          node_public_ip_tags            = node_network_profile.value.node_public_ip_tags

          dynamic "allowed_host_ports" {
            for_each = node_network_profile.value.allowed_host_ports == null ? [] : node_network_profile.value.allowed_host_ports
            content {
              port_end   = allowed_host_ports.value.port_end
              port_start = allowed_host_ports.value.port_start
              protocol   = allowed_host_ports.value.protocol
            }
          }
        }
      }
      dynamic "upgrade_settings" {
        for_each = default_node_pool.value.upgrade_settings == null ? [] : [default_node_pool.value.upgrade_settings]
        content {
          max_surge                     = upgrade_settings.value.max_surge
          drain_timeout_in_minutes      = upgrade_settings.value.drain_timeout_in_minutes
          node_soak_duration_in_minutes = upgrade_settings.value.node_soak_duration_in_minutes
        }
      }
    }
  }
  dynamic "aci_connector_linux" {
    for_each = var.kubernetes_cluster_aci_connector_linux == null ? [] : [var.kubernetes_cluster_aci_connector_linux]
    content {
      subnet_name = aci_connector_linux.value.subnet_name
    }
  }
  dynamic "api_server_access_profile" {
    for_each = var.kubernetes_cluster_api_server_access_profile == null ? [] : [var.kubernetes_cluster_api_server_access_profile]
    content {
      authorized_ip_ranges     = api_server_access_profile.value.authorized_ip_ranges
      subnet_id                = api_server_access_profile.value.subnet_id
      vnet_integration_enabled = api_server_access_profile.value.vnet_integration_enabled
    }
  }
  dynamic "auto_scaler_profile" {
    for_each = var.kubernetes_cluster_auto_scaler_profile == null ? [] : [var.kubernetes_cluster_auto_scaler_profile]
    content {
      balance_similar_node_groups      = auto_scaler_profile.value.balance_similar_node_groups
      empty_bulk_delete_max            = auto_scaler_profile.value.empty_bulk_delete_max
      expander                         = auto_scaler_profile.value.expander
      max_graceful_termination_sec     = auto_scaler_profile.value.max_graceful_termination_sec
      max_node_provisioning_time       = auto_scaler_profile.value.max_node_provisioning_time
      max_unready_nodes                = auto_scaler_profile.value.max_unready_nodes
      max_unready_percentage           = auto_scaler_profile.value.max_unready_percentage
      new_pod_scale_up_delay           = auto_scaler_profile.value.new_pod_scale_up_delay
      scale_down_delay_after_add       = auto_scaler_profile.value.scale_down_delay_after_add
      scale_down_delay_after_delete    = auto_scaler_profile.value.scale_down_delay_after_delete
      scale_down_delay_after_failure   = auto_scaler_profile.value.scale_down_delay_after_failure
      scale_down_unneeded              = auto_scaler_profile.value.scale_down_unneeded
      scale_down_unready               = auto_scaler_profile.value.scale_down_unready
      scale_down_utilization_threshold = auto_scaler_profile.value.scale_down_utilization_threshold
      scan_interval                    = auto_scaler_profile.value.scan_interval
      skip_nodes_with_local_storage    = auto_scaler_profile.value.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = auto_scaler_profile.value.skip_nodes_with_system_pods
    }
  }
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.kubernetes_cluster_azure_active_directory_role_based_access_control == null ? [] : [var.kubernetes_cluster_azure_active_directory_role_based_access_control]
    content {
      admin_group_object_ids = azure_active_directory_role_based_access_control.value.admin_group_object_ids
      azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_rbac_enabled
      client_app_id          = azure_active_directory_role_based_access_control.value.client_app_id
      managed                = azure_active_directory_role_based_access_control.value.managed
      server_app_id          = azure_active_directory_role_based_access_control.value.server_app_id
      server_app_secret      = azure_active_directory_role_based_access_control.value.server_app_secret
      tenant_id              = azure_active_directory_role_based_access_control.value.tenant_id
    }
  }
  dynamic "confidential_computing" {
    for_each = var.kubernetes_cluster_confidential_computing == null ? [] : [var.kubernetes_cluster_confidential_computing]
    content {
      sgx_quote_helper_enabled = confidential_computing.value.sgx_quote_helper_enabled
    }
  }
  dynamic "http_proxy_config" {
    for_each = var.kubernetes_cluster_http_proxy_config == null ? [] : [var.kubernetes_cluster_http_proxy_config]
    content {
      http_proxy  = http_proxy_config.value.http_proxy
      https_proxy = http_proxy_config.value.https_proxy
      no_proxy    = http_proxy_config.value.no_proxy
      trusted_ca  = http_proxy_config.value.trusted_ca
    }
  }
  dynamic "identity" {
    for_each = var.kubernetes_cluster_identity == null ? [] : [var.kubernetes_cluster_identity]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  dynamic "ingress_application_gateway" {
    for_each = var.kubernetes_cluster_ingress_application_gateway == null ? [] : [var.kubernetes_cluster_ingress_application_gateway]
    content {
      gateway_id   = ingress_application_gateway.value.gateway_id
      gateway_name = ingress_application_gateway.value.gateway_name
      subnet_cidr  = ingress_application_gateway.value.subnet_cidr
      subnet_id    = ingress_application_gateway.value.subnet_id
    }
  }
  dynamic "key_management_service" {
    for_each = var.kubernetes_cluster_key_management_service == null ? [] : [var.kubernetes_cluster_key_management_service]
    content {
      key_vault_key_id         = key_management_service.value.key_vault_key_id
      key_vault_network_access = key_management_service.value.key_vault_network_access
    }
  }
  dynamic "key_vault_secrets_provider" {
    for_each = var.kubernetes_cluster_key_vault_secrets_provider == null ? [] : [var.kubernetes_cluster_key_vault_secrets_provider]
    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
    }
  }
  dynamic "kubelet_identity" {
    for_each = var.kubernetes_cluster_kubelet_identity == null ? [] : [var.kubernetes_cluster_kubelet_identity]
    content {
      client_id                 = kubelet_identity.value.client_id
      object_id                 = kubelet_identity.value.object_id
      user_assigned_identity_id = kubelet_identity.value.user_assigned_identity_id
    }
  }
  dynamic "linux_profile" {
    for_each = var.kubernetes_cluster_linux_profile == null ? [] : [var.kubernetes_cluster_linux_profile]
    content {
      admin_username = linux_profile.value.admin_username

      dynamic "ssh_key" {
        for_each = [linux_profile.value.ssh_key]
        content {
          key_data = ssh_key.value.key_data
        }
      }
    }
  }
  dynamic "maintenance_window" {
    for_each = var.kubernetes_cluster_maintenance_window == null ? [] : [var.kubernetes_cluster_maintenance_window]
    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.allowed == null ? [] : maintenance_window.value.allowed
        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = maintenance_window.value.not_allowed == null ? [] : maintenance_window.value.not_allowed
        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }
  dynamic "maintenance_window_auto_upgrade" {
    for_each = var.kubernetes_cluster_maintenance_window_auto_upgrade == null ? [] : [var.kubernetes_cluster_maintenance_window_auto_upgrade]
    content {
      duration     = maintenance_window_auto_upgrade.value.duration
      frequency    = maintenance_window_auto_upgrade.value.frequency
      interval     = maintenance_window_auto_upgrade.value.interval
      day_of_month = maintenance_window_auto_upgrade.value.day_of_month
      day_of_week  = maintenance_window_auto_upgrade.value.day_of_week
      start_date   = maintenance_window_auto_upgrade.value.start_date
      start_time   = maintenance_window_auto_upgrade.value.start_time
      utc_offset   = maintenance_window_auto_upgrade.value.utc_offset
      week_index   = maintenance_window_auto_upgrade.value.week_index

      dynamic "not_allowed" {
        for_each = maintenance_window_auto_upgrade.value.not_allowed == null ? [] : maintenance_window_auto_upgrade.value.not_allowed
        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }
  dynamic "maintenance_window_node_os" {
    for_each = var.kubernetes_cluster_maintenance_window_node_os == null ? [] : [var.kubernetes_cluster_maintenance_window_node_os]
    content {
      duration     = maintenance_window_node_os.value.duration
      frequency    = maintenance_window_node_os.value.frequency
      interval     = maintenance_window_node_os.value.interval
      day_of_month = maintenance_window_node_os.value.day_of_month
      day_of_week  = maintenance_window_node_os.value.day_of_week
      start_date   = maintenance_window_node_os.value.start_date
      start_time   = maintenance_window_node_os.value.start_time
      utc_offset   = maintenance_window_node_os.value.utc_offset
      week_index   = maintenance_window_node_os.value.week_index

      dynamic "not_allowed" {
        for_each = maintenance_window_node_os.value.not_allowed == null ? [] : maintenance_window_node_os.value.not_allowed
        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }
  dynamic "microsoft_defender" {
    for_each = var.kubernetes_cluster_microsoft_defender == null ? [] : [var.kubernetes_cluster_microsoft_defender]
    content {
      log_analytics_workspace_id = microsoft_defender.value.log_analytics_workspace_id
    }
  }
  dynamic "monitor_metrics" {
    for_each = var.kubernetes_cluster_monitor_metrics == null ? [] : [var.kubernetes_cluster_monitor_metrics]
    content {
      annotations_allowed = monitor_metrics.value.annotations_allowed
      labels_allowed      = monitor_metrics.value.labels_allowed
    }
  }
  dynamic "network_profile" {
    for_each = var.kubernetes_cluster_network_profile == null ? [] : [var.kubernetes_cluster_network_profile]
    content {
      network_plugin          = network_profile.value.network_plugin
      dns_service_ip          = network_profile.value.dns_service_ip
      docker_bridge_cidr      = network_profile.value.docker_bridge_cidr
      ebpf_data_plane         = network_profile.value.ebpf_data_plane
      ip_versions             = network_profile.value.ip_versions
      load_balancer_sku       = network_profile.value.load_balancer_sku
      network_data_plane      = network_profile.value.network_data_plane
      network_mode            = network_profile.value.network_mode
      network_plugin_mode     = network_profile.value.network_plugin_mode
      network_policy          = network_profile.value.network_policy
      outbound_ip_address_ids = network_profile.value.outbound_ip_address_ids
      outbound_ip_prefix_ids  = network_profile.value.outbound_ip_prefix_ids
      outbound_type           = network_profile.value.outbound_type
      pod_cidr                = network_profile.value.pod_cidr
      pod_cidrs               = network_profile.value.pod_cidrs
      service_cidr            = network_profile.value.service_cidr
      service_cidrs           = network_profile.value.service_cidrs

      dynamic "load_balancer_profile" {
        for_each = network_profile.value.load_balancer_profile == null ? [] : [network_profile.value.load_balancer_profile]
        content {
          idle_timeout_in_minutes     = load_balancer_profile.value.idle_timeout_in_minutes
          managed_outbound_ip_count   = load_balancer_profile.value.managed_outbound_ip_count
          managed_outbound_ipv6_count = load_balancer_profile.value.managed_outbound_ipv6_count
          outbound_ip_address_ids     = load_balancer_profile.value.outbound_ip_address_ids
          outbound_ip_prefix_ids      = load_balancer_profile.value.outbound_ip_prefix_ids
          outbound_ports_allocated    = load_balancer_profile.value.outbound_ports_allocated
        }
      }
      dynamic "nat_gateway_profile" {
        for_each = network_profile.value.nat_gateway_profile == null ? [] : [network_profile.value.nat_gateway_profile]
        content {
          idle_timeout_in_minutes   = nat_gateway_profile.value.idle_timeout_in_minutes
          managed_outbound_ip_count = nat_gateway_profile.value.managed_outbound_ip_count
        }
      }
    }
  }
  dynamic "oms_agent" {
    for_each = var.kubernetes_cluster_oms_agent == null ? [] : [var.kubernetes_cluster_oms_agent]
    content {
      log_analytics_workspace_id      = oms_agent.value.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = oms_agent.value.msi_auth_for_monitoring_enabled
    }
  }
  dynamic "service_mesh_profile" {
    for_each = var.kubernetes_cluster_service_mesh_profile == null ? [] : [var.kubernetes_cluster_service_mesh_profile]
    content {
      mode                             = service_mesh_profile.value.mode
      external_ingress_gateway_enabled = service_mesh_profile.value.external_ingress_gateway_enabled
      internal_ingress_gateway_enabled = service_mesh_profile.value.internal_ingress_gateway_enabled

      dynamic "certificate_authority" {
        for_each = service_mesh_profile.value.certificate_authority == null ? [] : [service_mesh_profile.value.certificate_authority]
        content {
          cert_chain_object_name = certificate_authority.value.cert_chain_object_name
          cert_object_name       = certificate_authority.value.cert_object_name
          key_object_name        = certificate_authority.value.key_object_name
          key_vault_id           = certificate_authority.value.key_vault_id
          root_cert_object_name  = certificate_authority.value.root_cert_object_name
        }
      }
    }
  }
  dynamic "service_principal" {
    for_each = var.kubernetes_cluster_service_principal == null ? [] : [var.kubernetes_cluster_service_principal]
    content {
      client_id     = service_principal.value.client_id
      client_secret = service_principal.value.client_secret
    }
  }
  dynamic "storage_profile" {
    for_each = var.kubernetes_cluster_storage_profile == null ? [] : [var.kubernetes_cluster_storage_profile]
    content {
      blob_driver_enabled         = storage_profile.value.blob_driver_enabled
      disk_driver_enabled         = storage_profile.value.disk_driver_enabled
      disk_driver_version         = storage_profile.value.disk_driver_version
      file_driver_enabled         = storage_profile.value.file_driver_enabled
      snapshot_controller_enabled = storage_profile.value.snapshot_controller_enabled
    }
  }
  dynamic "timeouts" {
    for_each = var.kubernetes_cluster_timeouts == null ? [] : [var.kubernetes_cluster_timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
  dynamic "web_app_routing" {
    for_each = var.kubernetes_cluster_web_app_routing == null ? [] : [var.kubernetes_cluster_web_app_routing]
    content {
      dns_zone_id  = web_app_routing.value.dns_zone_id
      dns_zone_ids = web_app_routing.value.dns_zone_ids
    }
  }
  dynamic "windows_profile" {
    for_each = var.kubernetes_cluster_windows_profile == null ? [] : [var.kubernetes_cluster_windows_profile]
    content {
      admin_username = windows_profile.value.admin_username
      admin_password = windows_profile.value.admin_password
      license        = windows_profile.value.license

      dynamic "gmsa" {
        for_each = windows_profile.value.gmsa == null ? [] : [windows_profile.value.gmsa]
        content {
          dns_server  = gmsa.value.dns_server
          root_domain = gmsa.value.root_domain
        }
      }
    }
  }
  dynamic "workload_autoscaler_profile" {
    for_each = var.kubernetes_cluster_workload_autoscaler_profile == null ? [] : [var.kubernetes_cluster_workload_autoscaler_profile]
    content {
      keda_enabled                    = workload_autoscaler_profile.value.keda_enabled
      vertical_pod_autoscaler_enabled = workload_autoscaler_profile.value.vertical_pod_autoscaler_enabled
    }
  }
}

