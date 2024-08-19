locals {
  diffs = {
    "azurerm_analysis_services_server" : {
      "resource_type" : "azurerm_analysis_services_server",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "enable_power_bi_service",
          "power_bi_service_enabled"
        ]
      ]
    },
    "azurerm_api_management" : {
      "resource_type" : "azurerm_api_management",
      "deleted" : [
        "policy"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_api_management_api" : {
      "resource_type" : "azurerm_api_management_api",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "soap_pass_through",
          "api_type"
        ]
      ]
    },
    "azurerm_application_insights" : {
      "resource_type" : "azurerm_application_insights",
      "deleted" : null,
      "oc_removed" : [
        "daily_data_cap_notifications_disabled"
      ],
      "renamed" : null
    },
    "azurerm_attestation_provider" : {
      "resource_type" : "azurerm_attestation_provider",
      "deleted" : [
        "policy"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_automation_runbook" : {
      "resource_type" : "azurerm_automation_runbook",
      "deleted" : null,
      "oc_removed" : [
        "job_schedule"
      ],
      "renamed" : null
    },
    "azurerm_automation_software_update_configuration" : {
      "resource_type" : "azurerm_automation_software_update_configuration",
      "deleted" : [
        "operating_system"
      ],
      "oc_removed" : null,
      "renamed" : [
        [
          "windows.classification_included",
          "classifications_included"
        ],
        [
          "error_meesage",
          "error_message"
        ],
        [
          "linux.classification_included",
          "classifications_included"
        ]
      ]
    },
    "azurerm_bot_channel_web_chat" : {
      "resource_type" : "azurerm_bot_channel_web_chat",
      "deleted" : null,
      "oc_removed" : [
        "site"
      ],
      "renamed" : [
        [
          "site_names",
          "site"
        ]
      ]
    },
    "azurerm_bot_channels_registration" : {
      "resource_type" : "azurerm_bot_channels_registration",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "isolated_network_enabled",
          "public_network_access_enabled"
        ]
      ]
    },
    "azurerm_bot_connection" : {
      "resource_type" : "azurerm_bot_connection",
      "deleted" : [
        "tags"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_cdn_endpoint" : {
      "resource_type" : "azurerm_cdn_endpoint",
      "deleted" : null,
      "oc_removed" : [
        "probe_path",
        "origin_path",
        "content_types_to_compress"
      ],
      "renamed" : null
    },
    "azurerm_cdn_endpoint_custom_domain" : {
      "resource_type" : "azurerm_cdn_endpoint_custom_domain",
      "deleted" : [
        "user_managed_https.key_vault_certificate_id"
      ],
      "oc_removed" : [
        "user_managed_https.key_vault_secret_id"
      ],
      "renamed" : null
    },
    "azurerm_cdn_frontdoor_origin" : {
      "resource_type" : "azurerm_cdn_frontdoor_origin",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "health_probes_enabled",
          "enabled"
        ]
      ]
    },
    "azurerm_consumption_budget_management_group" : {
      "resource_type" : "azurerm_consumption_budget_management_group",
      "deleted" : [
        "filter.not"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_consumption_budget_resource_group" : {
      "resource_type" : "azurerm_consumption_budget_resource_group",
      "deleted" : [
        "filter.not"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_consumption_budget_subscription" : {
      "resource_type" : "azurerm_consumption_budget_subscription",
      "deleted" : [
        "filter.not"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_container_app_job" : {
      "resource_type" : "azurerm_container_app_job",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "registries",
          "registry"
        ],
        [
          "secrets",
          "secret"
        ]
      ]
    },
    "azurerm_container_group" : {
      "resource_type" : "azurerm_container_group",
      "deleted" : [
        "container.gpu",
        "container.gpu_limit"
      ],
      "oc_removed" : [
        "exposed_port"
      ],
      "renamed" : null
    },
    "azurerm_container_registry" : {
      "resource_type" : "azurerm_container_registry",
      "deleted" : [
        "network_rule_set.virtual_network",
        "trust_policy",
        "encryption.enabled",
        "retention_policy"
      ],
      "oc_removed" : [
        "network_rule_set",
        "encryption"
      ],
      "renamed" : null
    },
    "azurerm_cosmosdb_account" : {
      "resource_type" : "azurerm_cosmosdb_account",
      "deleted" : [
        "connection_strings"
      ],
      "oc_removed" : null,
      "renamed" : [
        [
          "enable_multiple_write_locations",
          "multiple_write_locations_enabled"
        ],
        [
          "enable_automatic_failover",
          "automatic_failover_enabled"
        ],
        [
          "enable_free_tier",
          "free_tier_enabled"
        ]
      ]
    },
    "azurerm_cosmosdb_sql_container" : {
      "resource_type" : "azurerm_cosmosdb_sql_container",
      "deleted" : null,
      "oc_removed" : [
        "partition_key_paths"
      ],
      "renamed" : [
        [
          "partition_key_path",
          "partition_key_paths"
        ]
      ]
    },
    "azurerm_data_protection_backup_policy_blob_storage" : {
      "resource_type" : "azurerm_data_protection_backup_policy_blob_storage",
      "deleted" : null,
      "oc_removed" : [
        "operational_default_retention_duration"
      ],
      "renamed" : [
        [
          "retention_duration",
          "operational_default_retention_duration"
        ]
      ]
    },
    "azurerm_databricks_workspace" : {
      "resource_type" : "azurerm_databricks_workspace",
      "deleted" : null,
      "oc_removed" : [
        "network_security_group_rules_required"
      ],
      "renamed" : null
    },
    "azurerm_dev_test_lab" : {
      "resource_type" : "azurerm_dev_test_lab",
      "deleted" : [
        "storage_type"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_elastic_cloud_elasticsearch" : {
      "resource_type" : "azurerm_elastic_cloud_elasticsearch",
      "deleted" : null,
      "oc_removed" : [
        "logs"
      ],
      "renamed" : null
    },
    "azurerm_eventhub_namespace" : {
      "resource_type" : "azurerm_eventhub_namespace",
      "deleted" : [
        "zone_redundant"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_iothub" : {
      "resource_type" : "azurerm_iothub",
      "deleted" : null,
      "oc_removed" : [
        "route",
        "endpoint",
        "enrichment"
      ],
      "renamed" : null
    },
    "azurerm_key_vault" : {
      "resource_type" : "azurerm_key_vault",
      "deleted" : null,
      "oc_removed" : [
        "access_policy"
      ],
      "renamed" : null
    },
    "azurerm_key_vault_managed_hardware_security_module_role_assignment" : {
      "resource_type" : "azurerm_key_vault_managed_hardware_security_module_role_assignment",
      "deleted" : null,
      "oc_removed" : [
        "managed_hsm_id"
      ],
      "renamed" : [
        [
          "vault_base_url",
          "managed_hsm_id"
        ]
      ]
    },
    "azurerm_key_vault_managed_hardware_security_module_role_definition" : {
      "resource_type" : "azurerm_key_vault_managed_hardware_security_module_role_definition",
      "deleted" : [
        "vault_base_url"
      ],
      "oc_removed" : [
        "managed_hsm_id"
      ],
      "renamed" : null
    },
    "azurerm_kubernetes_cluster" : {
      "resource_type" : "azurerm_kubernetes_cluster",
      "deleted" : [
        "web_app_routing.dns_zone_id",
        "default_node_pool.node_taints",
        "azure_active_directory_role_based_access_control.server_app_id",
        "azure_active_directory_role_based_access_control.server_app_secret",
        "azure_active_directory_role_based_access_control.managed",
        "azure_active_directory_role_based_access_control.client_app_id",
        "automatic_channel_upgrade",
        "workload_autoscaler_profile.vertical_pod_autoscaler_update_mode",
        "workload_autoscaler_profile.vertical_pod_autoscaler_controlled_values",
        "network_profile.docker_bridge_cidr",
        "network_profile.outbound_ip_prefix_ids",
        "network_profile.outbound_ip_address_ids",
        "node_os_channel_upgrade",
        "public_network_access_enabled",
        "enable_pod_security_policy"
      ],
      "oc_removed" : [
        "api_server_access_profile"
      ],
      "renamed" : [
        [
          "network_profile.ebpf_data_plane",
          "network_data_plane"
        ],
        [
          "api_server_authorized_ip_ranges",
          "authorized_ip_ranges"
        ]
      ]
    },
    "azurerm_kusto_cluster" : {
      "resource_type" : "azurerm_kusto_cluster",
      "deleted" : [
        "engine"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_linux_function_app" : {
      "resource_type" : "azurerm_linux_function_app",
      "deleted" : null,
      "oc_removed" : [
        "site_config.health_check_eviction_time_in_min"
      ],
      "renamed" : null
    },
    "azurerm_linux_virtual_machine_scale_set" : {
      "resource_type" : "azurerm_linux_virtual_machine_scale_set",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "scale_in_policy",
          "scale_in"
        ],
        [
          "gallery_applications",
          "gallery_application"
        ],
        [
          "terminate_notification",
          "termination_notification"
        ]
      ]
    },
    "azurerm_linux_web_app" : {
      "resource_type" : "azurerm_linux_web_app",
      "deleted" : [
        "site_config.application_stack.docker_image",
        "site_config.application_stack.docker_image_tag"
      ],
      "oc_removed" : [
        "site_config.application_stack.docker_registry_url",
        "site_config.application_stack.docker_registry_username",
        "site_config.application_stack.docker_registry_password",
        "site_config.health_check_eviction_time_in_min"
      ],
      "renamed" : [
        [
          "site_config.auto_heal_setting.trigger.slow_request.path",
          "slow_request_with_path"
        ]
      ]
    },
    "azurerm_linux_web_app_slot" : {
      "resource_type" : "azurerm_linux_web_app_slot",
      "deleted" : [
        "site_config.application_stack.docker_image_tag",
        "site_config.application_stack.docker_image"
      ],
      "oc_removed" : [
        "site_config.application_stack.docker_registry_url",
        "site_config.application_stack.docker_registry_username",
        "site_config.application_stack.docker_registry_password",
        "site_config.health_check_eviction_time_in_min"
      ],
      "renamed" : [
        [
          "site_config.auto_heal_setting.trigger.slow_request.path",
          "slow_request_with_path"
        ]
      ]
    },
    "azurerm_logic_app_standard" : {
      "resource_type" : "azurerm_logic_app_standard",
      "deleted" : null,
      "oc_removed" : [
        "site_config.scm_ip_restriction",
        "site_config.scm_ip_restriction.headers",
        "site_config.ip_restriction",
        "site_config.ip_restriction.headers"
      ],
      "renamed" : null
    },
    "azurerm_machine_learning_compute_instance" : {
      "resource_type" : "azurerm_machine_learning_compute_instance",
      "deleted" : [
        "location"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_machine_learning_workspace" : {
      "resource_type" : "azurerm_machine_learning_workspace",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "public_access_behind_virtual_network_enabled",
          "public_network_access_enabled"
        ]
      ]
    },
    "azurerm_managed_application" : {
      "resource_type" : "azurerm_managed_application",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "parameters",
          "parameter_values"
        ]
      ]
    },
    "azurerm_managed_disk" : {
      "resource_type" : "azurerm_managed_disk",
      "deleted" : [
        "encryption_settings.enabled"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_management_group_policy_remediation" : {
      "resource_type" : "azurerm_management_group_policy_remediation",
      "deleted" : [
        "resource_discovery_mode"
      ],
      "oc_removed" : null,
      "renamed" : [
        [
          "policy_definition_id",
          "policy_definition_reference_id"
        ]
      ]
    },
    "azurerm_maps_account" : {
      "resource_type" : "azurerm_maps_account",
      "deleted" : null,
      "oc_removed" : [
        "location"
      ],
      "renamed" : null
    },
    "azurerm_monitor_aad_diagnostic_setting" : {
      "resource_type" : "azurerm_monitor_aad_diagnostic_setting",
      "deleted" : null,
      "oc_removed" : [
        "enabled_log"
      ],
      "renamed" : [
        [
          "log",
          "enabled_log"
        ]
      ]
    },
    "azurerm_monitor_action_group" : {
      "resource_type" : "azurerm_monitor_action_group",
      "deleted" : [
        "event_hub_receiver.event_hub_id"
      ],
      "oc_removed" : [
        "event_hub_receiver.event_hub_name",
        "event_hub_receiver.event_hub_namespace"
      ],
      "renamed" : null
    },
    "azurerm_monitor_data_collection_rule" : {
      "resource_type" : "azurerm_monitor_data_collection_rule",
      "deleted" : null,
      "oc_removed" : [
        "data_sources.syslog.streams"
      ],
      "renamed" : null
    },
    "azurerm_monitor_diagnostic_setting" : {
      "resource_type" : "azurerm_monitor_diagnostic_setting",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "log",
          "enabled_log"
        ]
      ]
    },
    "azurerm_netapp_snapshot_policy" : {
      "resource_type" : "azurerm_netapp_snapshot_policy",
      "deleted" : null,
      "oc_removed" : [
        "monthly_schedule",
        "daily_schedule",
        "weekly_schedule",
        "hourly_schedule"
      ],
      "renamed" : null
    },
    "azurerm_network_connection_monitor" : {
      "resource_type" : "azurerm_network_connection_monitor",
      "deleted" : null,
      "oc_removed" : [
        "output_workspace_resource_ids"
      ],
      "renamed" : null
    },
    "azurerm_network_interface" : {
      "resource_type" : "azurerm_network_interface",
      "deleted" : null,
      "oc_removed" : [],
      "renamed" : [
        [
          "enable_accelerated_networking",
          "accelerated_networking_enabled"
        ],
        [
          "enable_ip_forwarding",
          "ip_forwarding_enabled"
        ]
      ]
    },
    "azurerm_network_security_group" : {
      "resource_type" : "azurerm_network_security_group",
      "deleted" : null,
      "oc_removed" : [
        "security_rule"
      ],
      "renamed" : null
    },
    "azurerm_nginx_deployment" : {
      "resource_type" : "azurerm_nginx_deployment",
      "deleted" : [
        "configuration"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_private_endpoint" : {
      "resource_type" : "azurerm_private_endpoint",
      "deleted" : null,
      "oc_removed" : [
        "ip_configuration.member_name"
      ],
      "renamed" : null
    },
    "azurerm_recovery_services_vault_resource_guard_association" : {
      "resource_type" : "azurerm_recovery_services_vault_resource_guard_association",
      "deleted" : [
        "name"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_redis_enterprise_database" : {
      "resource_type" : "azurerm_redis_enterprise_database",
      "deleted" : [
        "resource_group_name"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_resource_group_policy_remediation" : {
      "resource_type" : "azurerm_resource_group_policy_remediation",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "policy_definition_id",
          "policy_definition_reference_id"
        ]
      ]
    },
    "azurerm_resource_policy_remediation" : {
      "resource_type" : "azurerm_resource_policy_remediation",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "policy_definition_id",
          "policy_definition_reference_id"
        ]
      ]
    },
    "azurerm_route_table" : {
      "resource_type" : "azurerm_route_table",
      "deleted" : null,
      "oc_removed" : [
        "route"
      ],
      "renamed" : [
        [
          "disable_bgp_route_propagation",
          "bgp_route_propagation_enabled"
        ]
      ]
    },
    "azurerm_sentinel_alert_rule_ms_security_incident" : {
      "resource_type" : "azurerm_sentinel_alert_rule_ms_security_incident",
      "deleted" : null,
      "oc_removed" : [
        "display_name_filter"
      ],
      "renamed" : null
    },
    "azurerm_sentinel_alert_rule_nrt" : {
      "resource_type" : "azurerm_sentinel_alert_rule_nrt",
      "deleted" : null,
      "oc_removed" : [
        "event_grouping"
      ],
      "renamed" : null
    },
    "azurerm_sentinel_alert_rule_scheduled" : {
      "resource_type" : "azurerm_sentinel_alert_rule_scheduled",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "incident_configuration",
          "incident"
        ]
      ]
    },
    "azurerm_sentinel_automation_rule" : {
      "resource_type" : "azurerm_sentinel_automation_rule",
      "deleted" : [
        "condition"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_sentinel_log_analytics_workspace_onboarding" : {
      "resource_type" : "azurerm_sentinel_log_analytics_workspace_onboarding",
      "deleted" : [
        "resource_group_name"
      ],
      "oc_removed" : null,
      "renamed" : [
        [
          "workspace_name",
          "workspace_id"
        ]
      ]
    },
    "azurerm_servicebus_namespace" : {
      "resource_type" : "azurerm_servicebus_namespace",
      "deleted" : [
        "zone_redundant"
      ],
      "oc_removed" : [
        "network_rule_set"
      ],
      "renamed" : null
    },
    "azurerm_servicebus_queue" : {
      "resource_type" : "azurerm_servicebus_queue",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "enable_partitioning",
          "partitioning_enabled"
        ],
        [
          "enable_batched_operations",
          "batched_operations_enabled"
        ],
        [
          "enable_express",
          "express_enabled"
        ]
      ]
    },
    "azurerm_servicebus_subscription" : {
      "resource_type" : "azurerm_servicebus_subscription",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "enable_batched_operations",
          "batched_operations_enabled"
        ]
      ]
    },
    "azurerm_servicebus_topic" : {
      "resource_type" : "azurerm_servicebus_topic",
      "deleted" : null,
      "oc_removed" : [
        "express_enabled",
        "partitioning_enabled",
        "batched_operations_enabled"
      ],
      "renamed" : [
        [
          "enable_batched_operations",
          "batched_operations_enabled"
        ],
        [
          "enable_partitioning",
          "partitioning_enabled"
        ],
        [
          "enable_express",
          "express_enabled"
        ]
      ]
    },
    "azurerm_signalr_service" : {
      "resource_type" : "azurerm_signalr_service",
      "deleted" : null,
      "oc_removed" : [
        "cors"
      ],
      "renamed" : null
    },
    "azurerm_site_recovery_replicated_vm" : {
      "resource_type" : "azurerm_site_recovery_replicated_vm",
      "deleted" : [
        "network_interface.is_primary"
      ],
      "oc_removed" : [
        "network_interface"
      ],
      "renamed" : null
    },
    "azurerm_site_recovery_replication_recovery_plan" : {
      "resource_type" : "azurerm_site_recovery_replication_recovery_plan",
      "deleted" : null,
      "oc_removed" : [
        "boot_recovery_group",
        "failover_recovery_group",
        "shutdown_recovery_group"
      ],
      "renamed" : [
        [
          "recovery_group",
          "shutdown_recovery_group"
        ]
      ]
    },
    "azurerm_snapshot" : {
      "resource_type" : "azurerm_snapshot",
      "deleted" : [
        "encryption_settings.enabled"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_storage_account" : {
      "resource_type" : "azurerm_storage_account",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "enable_https_traffic_only",
          "https_traffic_only_enabled"
        ]
      ]
    },
    "azurerm_storage_share_directory" : {
      "resource_type" : "azurerm_storage_share_directory",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "storage_account_name",
          "storage_share_id"
        ],
        [
          "share_name",
          "storage_share_id"
        ]
      ]
    },
    "azurerm_storage_table_entity" : {
      "resource_type" : "azurerm_storage_table_entity",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "table_name",
          "storage_table_id"
        ],
        [
          "storage_account_name",
          "storage_table_id"
        ]
      ]
    },
    "azurerm_subnet" : {
      "resource_type" : "azurerm_subnet",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "enforce_private_link_endpoint_network_policies",
          "private_endpoint_network_policies"
        ],
        [
          "enforce_private_link_service_network_policies",
          "private_link_service_network_policies_enabled"
        ],
        [
          "private_endpoint_network_policies_enabled",
          "private_endpoint_network_policies"
        ]
      ]
    },
    "azurerm_subscription_policy_remediation" : {
      "resource_type" : "azurerm_subscription_policy_remediation",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "policy_definition_id",
          "policy_definition_reference_id"
        ]
      ]
    },
    "azurerm_synapse_workspace" : {
      "resource_type" : "azurerm_synapse_workspace",
      "deleted" : [
        "aad_admin",
        "sql_aad_admin"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_virtual_network" : {
      "resource_type" : "azurerm_virtual_network",
      "deleted" : [
        "subnet.address_prefix"
      ],
      "oc_removed" : [
        "subnet"
      ],
      "renamed" : null
    },
    "azurerm_virtual_network_gateway_connection" : {
      "resource_type" : "azurerm_virtual_network_gateway_connection",
      "deleted" : null,
      "oc_removed" : [
        "shared_key"
      ],
      "renamed" : null
    },
    "azurerm_vpn_gateway_nat_rule" : {
      "resource_type" : "azurerm_vpn_gateway_nat_rule",
      "deleted" : [
        "resource_group_name"
      ],
      "oc_removed" : [
        "internal_mapping",
        "external_mapping"
      ],
      "renamed" : [
        [
          "external_address_space_mappings",
          "external_mapping"
        ],
        [
          "internal_address_space_mappings",
          "internal_mapping"
        ]
      ]
    },
    "azurerm_web_application_firewall_policy" : {
      "resource_type" : "azurerm_web_application_firewall_policy",
      "deleted" : null,
      "oc_removed" : [
        "managed_rules.managed_rule_set.rule_group_override.rule"
      ],
      "renamed" : [
        [
          "managed_rules.managed_rule_set.rule_group_override.disabled_rules",
          "rule"
        ]
      ]
    },
    "azurerm_windows_function_app" : {
      "resource_type" : "azurerm_windows_function_app",
      "deleted" : null,
      "oc_removed" : [
        "site_config.health_check_eviction_time_in_min"
      ],
      "renamed" : null
    },
    "azurerm_windows_virtual_machine_scale_set" : {
      "resource_type" : "azurerm_windows_virtual_machine_scale_set",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "gallery_applications",
          "gallery_application"
        ],
        [
          "scale_in_policy",
          "scale_in"
        ],
        [
          "terminate_notification",
          "termination_notification"
        ]
      ]
    },
    "azurerm_windows_web_app" : {
      "resource_type" : "azurerm_windows_web_app",
      "deleted" : [
        "site_config.application_stack.docker_container_registry",
        "site_config.application_stack.docker_container_tag",
        "site_config.application_stack.docker_container_name",
        "site_config.application_stack.python_version"
      ],
      "oc_removed" : [
        "site_config.application_stack.docker_registry_password",
        "site_config.application_stack.docker_registry_url",
        "site_config.application_stack.docker_registry_username",
        "site_config.health_check_eviction_time_in_min"
      ],
      "renamed" : [
        [
          "site_config.auto_heal_setting.trigger.slow_request.path",
          "slow_request_with_path"
        ]
      ]
    },
    "azurerm_windows_web_app_slot" : {
      "resource_type" : "azurerm_windows_web_app_slot",
      "deleted" : [
        "site_config.application_stack.docker_container_tag",
        "site_config.application_stack.docker_container_name",
        "site_config.application_stack.docker_container_registry",
        "site_config.application_stack.python_version"
      ],
      "oc_removed" : [
        "site_config.application_stack.docker_registry_password",
        "site_config.application_stack.docker_registry_url",
        "site_config.application_stack.docker_registry_username",
        "site_config.health_check_eviction_time_in_min"
      ],
      "renamed" : [
        [
          "site_config.auto_heal_setting.trigger.slow_request.path",
          "slow_request_with_path"
        ]
      ]
    }
  }
  simply_renamed = flatten([for resource_type, renames in {
    azurerm_automation_software_update_configuration = [
      {
        from        = "error_meesage"
        to          = "error_message"
        replace_ref = true
      }
    ]
    azurerm_bot_channels_registration = [
      {
        from        = "isolated_network_enabled"
        to          = "public_network_access_enabled"
        replace_ref = true
      }
    ]
    azurerm_cdn_frontdoor_origin = [
      {
        from        = "health_probes_enabled"
        to          = "enabled"
        replace_ref = true
      }
    ]
    azurerm_container_app_job = [
      {
        from        = "secrets"
        to          = "secret"
        replace_ref = true
      },
      {
        from        = "registries"
        to          = "registry"
        replace_ref = true
      },
    ]
    azurerm_linux_virtual_machine_scale_set = [
      {
        from        = "gallery_applications.package_reference_id"
        to          = "version_id"
        replace_ref = false
      },
      {
        from        = "gallery_applications.configuration_reference_blob_uri"
        to          = "configuration_blob_uri"
        replace_ref = false
      },
      {
        from        = "gallery_applications"
        to          = "gallery_application"
        replace_ref = true
      },
    ]
    azurerm_data_protection_backup_policy_blob_storage = [
      {
        from        = "retention_duration"
        to          = "operational_default_retention_duration"
        replace_ref = true
      }
    ]
    azurerm_kubernetes_cluster = [
      {
        from        = "network_profile.ebpf_data_plane"
        to          = "network_data_plane"
        replace_ref = true
      },
      {
        from        = "api_server_authorized_ip_ranges"
        to          = "authorized_ip_ranges"
        replace_ref = true
      }
    ]
    azurerm_monitor_aad_diagnostic_setting = [
      {
        from        = "log"
        to          = "enabled_log"
        replace_ref = true
      }
    ]
    azurerm_monitor_diagnostic_setting = [
      {
        from        = "log"
        to          = "enabled_log"
        replace_ref = true
      }
    ]
    azurerm_management_group_policy_remediation = [
      {
        from        = "policy_definition_id"
        to          = "policy_definition_reference_id"
        replace_ref = true
      }
    ]
    azurerm_resource_group_policy_remediation = [
      {
        from        = "policy_definition_id"
        to          = "policy_definition_reference_id"
        replace_ref = true
      }
    ]
    azurerm_resource_policy_remediation = [
      {
        from        = "policy_definition_id"
        to          = "policy_definition_reference_id"
        replace_ref = true
      }
    ]
    azurerm_subscription_policy_remediation = [
      {
        from        = "policy_definition_id"
        to          = "policy_definition_reference_id"
        replace_ref = true
      }
    ]
    } : [for rename in renames : {
      resource_type = resource_type
      from          = rename.from
      to            = rename.to
      replace_ref   = rename.replace_ref
    }]
  ])
}

data "resource" all {
}

locals {
  oc_removed_arguments        = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if try(local.diffs[resource_type].oc_removed != null, false)])
  oc_removed_mptfs            = flatten([for _, blocks in local.oc_removed_arguments : [for b in blocks : b.mptf]])
  oc_removed_addresses        = [for mptf in local.oc_removed_mptfs : mptf.block_address]
  all_resources               = { for obj in flatten([for obj in flatten([for b in data.resource.all.result.* : [for nb in b : nb]]) : [for body in obj : body]]) : obj.mptf.block_address => obj }
  attribute_removed           = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if try(local.diffs[resource_type].deleted != null, false)])
  attribute_removed_mptfs     = flatten([for _, blocks in local.attribute_removed : [for b in blocks : b.mptf]])
  attribute_removed_addresses = [for mptf in local.attribute_removed_mptfs : mptf.block_address]
  enable_to_enabled = { for k, v in local.diffs :
    k => {
      renamed = [for l in try(v.renamed == null ? [] : v.renamed) : l
    if("enable_${l[0]}" == "${l[1]}_enabled") || ("enable_${l[1]}" == "${l[0]}_enabled")] }
  if anytrue([for l in try(v.renamed == null ? [] : v.renamed, []) : ("enable_${l[0]}" == "${l[1]}_enabled") || ("enable_${l[1]}" == "${l[0]}_enabled")]) }
  flatten_enable_to_enabled = flatten([for k, v in local.enable_to_enabled : flatten([for i in v.renamed : {
    resource_type = k
    from          = i[0]
    to            = i[1]
  }])])
  enable_to_enabled_blocks = toset(flatten([
    for k, v in local.all_resources : [
      for obj in local.flatten_enable_to_enabled : {
        block_address = k
        mptf          = v.mptf
        from          = obj.from
        to            = obj.to
      } if v.mptf.block_labels[0] == obj.resource_type
    ]
  ]))
  monitor_diagnostic_setting_types              = toset(["azurerm_monitor_aad_diagnostic_setting", "azurerm_monitor_diagnostic_setting"])
  monitor_diagnostic_setting_resource_blocks    = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if contains(local.monitor_diagnostic_setting_types, resource_type)])
  monitor_diagnostic_setting_resource_mptfs     = flatten([for _, blocks in local.monitor_diagnostic_setting_resource_blocks : [for b in blocks : b.mptf]])
  monitor_diagnostic_setting_resource_addresses = [for mptf in local.monitor_diagnostic_setting_resource_mptfs : mptf.block_address]
}

transform "update_in_place" oc_removed {
  for_each             = [] /*try(local.oc_removed_addresses, [])*/
  target_block_address = each.value
  asstring {
    lifecycle {
      ignore_changes = <<-IGNORE
    %{if try(local.all_resources[each.value].lifecycle[0].ignore_changes != "", false)} [${trimsuffix(trimprefix(local.all_resources[each.value].lifecycle[0].ignore_changes, "["), "]")}, ${join(" ,", local.diffs[split(".", local.all_resources[each.value].mptf.terraform_address)[0]].oc_removed)}]
    %{else} [${join(" ,", local.diffs[local.all_resources[each.value].mptf.block_labels[0]].oc_removed)}]
    %{endif}
IGNORE
    }
  }
}

transform "remove_block_element" attribute_removed {
  for_each             = try(local.attribute_removed_addresses, [])
  target_block_address = each.value
  paths                = local.diffs[local.all_resources[each.value].mptf.block_labels[0]].deleted
  depends_on           = [transform.regex_replace_expression.simply_renamed]
}

transform rename_block_element enable_to_enabled {
  dynamic "rename" {
    for_each = toset(local.enable_to_enabled_blocks)
    content {
      resource_type  = rename.value.mptf.block_labels[0]
      attribute_path = [rename.value.from]
      new_name       = rename.value.to
    }
  }
}

transform regex_replace_expression enable_to_enabled {
  for_each    = toset(local.enable_to_enabled_blocks)
  regex       = "${each.value.mptf.block_labels[0]}\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${each.value.from}"
  replacement = "${each.value.mptf.block_labels[0]}.$${1}$${2}$${3}$${4}$${5}${each.value.to}"
  depends_on  = [transform.rename_block_element.enable_to_enabled]
}

transform rename_block_element simply_renamed {
  dynamic "rename" {
    for_each = local.simply_renamed
    content {
      resource_type  = rename.value.resource_type
      attribute_path = split(".", rename.value.from)
      new_name       = rename.value.to
    }
  }
  depends_on = [
    transform.remove_block_element.monitor_diagnostic_setting,
    transform.regex_replace_expression.simply_renamed
  ]
}

transform regex_replace_expression simply_renamed {
  for_each    = [for rename in local.rename_with_replacement : rename]
  regex       = each.value.regex
  replacement = each.value.replacement
  depends_on = [
    transform.regex_replace_expression.azurerm_linux_virtual_machine_scale_set_gallery_application,
  ]
}

locals {
  #                    dot | potential new line | label[1] | potential index or splat | dot | potential new line
  middle_path_regex = "(\\.)(\\s*\\r?\\n\\s*)?"
  inputs = [
    "enable_xxx",
    "gallery_applications.package_reference_id",
  ]
  rename_with_replacement = [for item_with_replacement in [for item_with_regex in [for item in [for rename in local.simply_renamed : {
    resource_type = rename.resource_type
    paths         = split(".", rename.from)
    to            = rename.to
    } if rename.replace_ref] : {
    resource_type = item.resource_type
    paths         = item.paths
    to            = item.to
    regex = join("((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?", [
      for i in range(length(item.paths)) : "${item.paths[i]}"
    ])
    }] :
    {
      resource_type = item_with_regex.resource_type
      paths         = item_with_regex.paths
      to            = item_with_regex.to
      regex         = "${item_with_regex.resource_type}\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${item_with_regex.regex}"
      replacement   = [for i, path in slice(item_with_regex.paths, 0, length(item_with_regex.paths) - 1) : "${path}$${${(i * 3 + 6)}}$${${(i * 3 + 7)}}$${${(i * 3 + 8)}}"]
    }
    ] : {
    resource_type = item_with_replacement.resource_type
    paths         = item_with_replacement.paths
    to            = item_with_replacement.to
    regex         = item_with_replacement.regex
    replacement   = "${item_with_replacement.resource_type}.$${1}$${2}$${3}$${4}$${5}${join("", item_with_replacement.replacement)}${item_with_replacement.to}"
  }]
}

transform regex_replace_expression azurerm_linux_virtual_machine_scale_set_gallery_application {
  for_each = tomap({
    "package_reference_id" : "version_id",
    "configuration_reference_blob_uri" : "configuration_blob_uri",
  })
  regex       = "azurerm_linux_virtual_machine_scale_set\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?gallery_applications((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?${each.key}"
  replacement = "azurerm_linux_virtual_machine_scale_set.$${1}$${2}$${3}$${4}$${5}gallery_application$${6}$${7}$${8}${each.value}"
}

transform remove_block_element monitor_diagnostic_setting {
  for_each             = local.monitor_diagnostic_setting_resource_addresses
  target_block_address = each.value
  paths                = ["log.enabled"]
}

locals {
  subnet_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_subnet"]) : [for b in blocks : b]])
  subnet_resource_blocks_map = { for block in local.subnet_resource_blocks : block.mptf.block_address => block }
  subnet_resource_addresses  = keys(local.subnet_resource_blocks_map)
  subnet_enforce_private_link_endpoint_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.enforce_private_link_endpoint_network_policies, "false")
  }
  subnet_enforce_private_link_service_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.enforce_private_link_service_network_policies, "false")
  }
  subnet_private_endpoint_network_policies_enabled = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.private_endpoint_network_policies_enabled, "false")
  }
  subnet_private_link_service_network_policies_enabled = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.private_link_service_network_policies_enabled, "false")
  }
  subnet_private_endpoint_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.private_endpoint_network_policies, "null")
  }
  subnet_enforce = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.enforce_private_link_endpoint_network_policies)}!=null", "false")
  }
  subnet_enable = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.private_endpoint_network_policies_enabled)}!=null", "false")
  }
  subnet_enforce_service = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.enforce_private_link_service_network_policies)}!=null", "false")
  }
  subnet_enable_service = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.private_link_service_network_policies_enabled)}!=null", "false")
  }
  subnet_private_endpoint_network_policies_ok = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.private_endpoint_network_policies)}!=null", "false")
  }
  # enforceOk || enableOk || privateEndpointNetworkPoliciesOk
  subnet_enforce_or_enable_or_private_endpoint_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => join(" || ", [local.subnet_enforce[block.mptf.block_address], local.subnet_enable[block.mptf.block_address], local.subnet_private_endpoint_network_policies_ok[block.mptf.block_address]])
  }
  subnet_enforce_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.enforce_private_link_endpoint_network_policies, false)} ? (\"Disabled\") : (\"Enabled\")"
  }
  subnet_enable_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.private_endpoint_network_policies_enabled, false)} ? (\"Enabled\") : (\"Disabled\")"
  }
  subnet_private_endpoint_network_policies_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.private_endpoint_network_policies, null)}"
  }
  subnet_private_endpoint_network_value = {
    for key, block in local.subnet_resource_blocks_map : key => "(${local.subnet_enforce_or_enable_or_private_endpoint_network_policies[block.mptf.block_address]}) ? (${local.subnet_enable[block.mptf.block_address]} ? (${local.subnet_enable_branch[block.mptf.block_address]}) : ((${local.subnet_enforce[block.mptf.block_address]}) ? (${local.subnet_enforce_branch[block.mptf.block_address]}) : (${local.subnet_private_endpoint_network_policies[block.mptf.block_address]}))) : (\"Enabled\")"
  }
  subnet_enforce_service_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "!${try(block.enforce_private_link_service_network_policies, false)}"
  }
  subnet_enable_service_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.private_link_service_network_policies_enabled, false)}"
  }
  subnet_private_link_service_network_value = {
    for key, block in local.subnet_resource_blocks_map : key => "(${local.subnet_enforce_service[key]}) ? (${local.subnet_enforce_service_branch[key]}) : (true)"
  }
}

transform "update_in_place" subnet_private_endpoint_network_policies {
  for_each             = try(local.subnet_private_endpoint_network_value, [])
  target_block_address = each.key
  asstring {
    private_endpoint_network_policies = coalesce(try(local.subnet_resource_blocks_map[each.key].private_endpoint_network_policies, null), each.value)
  }
}

transform "update_in_place" subnet_private_link_service_network_policies {
  for_each             = try(local.subnet_private_link_service_network_value, [])
  target_block_address = each.key
  asstring {
    private_link_service_network_policies_enabled = coalesce(try(local.subnet_resource_blocks_map[each.key].private_link_service_network_policies_enabled, null), each.value)
  }
  depends_on = [
    transform.update_in_place.subnet_private_endpoint_network_policies,
  ]
}

locals {
  subnet_deprecated_attributes = [
    "private_endpoint_network_policies_enabled",
    "enforce_private_link_endpoint_network_policies",
    "enforce_private_link_service_network_policies",
  ]
}

transform "remove_block_element" subnet_deprecated_attributes {
  for_each             = local.subnet_resource_addresses
  target_block_address = each.value
  paths                = local.subnet_deprecated_attributes
  depends_on = [
    transform.update_in_place.subnet_private_link_service_network_policies,
  ]
}

locals {
  api_management_api_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_api_management_api"]) : [for b in blocks : b]])
  api_management_api_resource_blocks_map = { for block in local.api_management_api_resource_blocks : block.mptf.block_address => block }
  api_management_api_resource_addresses  = keys(local.api_management_api_resource_blocks_map)
  api_management_api_with_soap_pass_through = {
    for key, block in local.api_management_api_resource_blocks_map : key => block if try(tostring(block.soap_pass_through) != null, false)
  }
}

transform "update_in_place" api_management_api_with_soap_pass_through {
  for_each             = local.api_management_api_with_soap_pass_through
  target_block_address = each.key
  asstring {
    api_type = coalesce(try(local.api_management_api_resource_blocks_map[each.key].api_type, null), "((${local.api_management_api_resource_blocks_map[each.key].soap_pass_through}) == null) ? (\"http\") : ((${local.api_management_api_resource_blocks_map[each.key].soap_pass_through}) ? \"soap\" : \"http\")")
  }
}

transform "remove_block_element" api_management_api_with_soap_pass_through {
  for_each             = local.api_management_api_with_soap_pass_through
  target_block_address = each.key
  paths                = ["soap_pass_through"]
  depends_on = [
    transform.update_in_place.api_management_api_with_soap_pass_through,
  ]
}

locals {
  key_vault_managed_hardware_security_module_role_assignment_resource_blocks          = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_key_vault_managed_hardware_security_module_role_assignment"]) : [for b in blocks : b]])
  key_vault_managed_hardware_security_module_role_assignment_resource_block_providers = toset([for _, block in local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map : try(block.provider, "azurerm")])
  key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map      = { for block in local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks : block.mptf.block_address => block if can(block.vault_base_url) && !can(block.managed_hsm_id) }
  key_vault_managed_hardware_security_module_role_assignment_resource_addresses       = keys(local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map)
}

transform "new_block" all_key_vault_hsm {
  for_each       = length(local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks) > 0 ? toset(concat(tolist(local.key_vault_managed_hardware_security_module_role_assignment_resource_block_providers), ["azurerm"])) : []
  new_block_type = "data"
  filename       = local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks[0].mptf.range.file_name
  labels         = ["azurerm_resources", replace("all_key_vault_hsm_${each.value}", ".", "_")]
  asstring {
    type     = "\"Microsoft.KeyVault/managedHSMs\""
    provider = each.value
  }
}

locals {
  key_vault_managed_hardware_security_module_role_assignment_hsm_data_source_block = {
    for key, block in local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map : key => replace("all_key_vault_hsm_${try(block.provider, "azurerm")}", ".", "_")
  }
}

transform "update_in_place" key_vault_managed_hardware_security_module_role_assignment {
  for_each             = local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map
  target_block_address = each.key
  asstring {
    managed_hsm_id = "one([for block in ${local.key_vault_managed_hardware_security_module_role_assignment_hsm_data_source_block[each.key]}.resources : block.id if \"https://$${block.name}.managedhsm.azure.net/\" == (${each.value.vault_base_url})]).id"
  }
}

transform "remove_block_element" key_vault_managed_hardware_security_module_role_assignment {
  for_each             = local.key_vault_managed_hardware_security_module_role_assignment_resource_addresses
  target_block_address = each.value
  paths                = ["vault_base_url"]
  depends_on = [
    transform.update_in_place.key_vault_managed_hardware_security_module_role_assignment,
  ]
}

locals {
  automation_software_update_configuration_blocks                                               = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_automation_software_update_configuration"]) : [for b in blocks : b]])
  automation_software_update_configuration_blocks_with_linux_classification_included_only       = [for block in local.automation_software_update_configuration_blocks : block if try(block.linux[0].classification_included != "", false) && !can(block.linux[0].classifications_included)]
  automation_software_update_configuration_blocks_with_windows_classification_included_only     = [for block in local.automation_software_update_configuration_blocks : block if try(block.windows[0].classification_included != "", false) && !can(block.windows[0].classifications_included)]
  automation_software_update_configuration_blocks_with_linux_classification_included_only_map   = { for block in local.automation_software_update_configuration_blocks_with_linux_classification_included_only : block.mptf.block_address => block }
  automation_software_update_configuration_blocks_with_windows_classification_included_only_map = { for block in local.automation_software_update_configuration_blocks_with_windows_classification_included_only : block.mptf.block_address => block }
}

transform "update_in_place" automation_software_update_configuration_linux_classification_included_only {
  for_each             = local.automation_software_update_configuration_blocks_with_linux_classification_included_only_map
  target_block_address = each.key
  asstring {
    linux {
      classifications_included = "[${each.value.linux[0].classification_included}]"
    }
  }
}

transform "update_in_place" automation_software_update_configuration_windows_classification_included_only {
  for_each             = local.automation_software_update_configuration_blocks_with_windows_classification_included_only_map
  target_block_address = each.key
  asstring {
    windows {
      classifications_included = "[${each.value.windows[0].classification_included}]"
    }
  }
}

transform "remove_block_element" automation_software_update_configuration {
  for_each             = merge(local.automation_software_update_configuration_blocks_with_linux_classification_included_only_map, local.automation_software_update_configuration_blocks_with_windows_classification_included_only_map)
  target_block_address = each.key
  paths                = ["linux.classification_included", "windows.classification_included"]
  depends_on = [
    transform.update_in_place.automation_software_update_configuration_linux_classification_included_only,
    transform.update_in_place.automation_software_update_configuration_windows_classification_included_only,
  ]
}