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
          "error_meesage",
          "error_message"
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
        "origin_path",
        "probe_path",
        "content_types_to_compress"
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
    "azurerm_container_app_job" : {
      "resource_type" : "azurerm_container_app_job",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "secrets",
          "secret"
        ],
        [
          "registries",
          "registry"
        ]
      ]
    },
    "azurerm_container_group" : {
      "resource_type" : "azurerm_container_group",
      "deleted" : null,
      "oc_removed" : [
        "exposed_port"
      ],
      "renamed" : null
    },
    "azurerm_container_registry" : {
      "resource_type" : "azurerm_container_registry",
      "deleted" : [
        "retention_policy",
        "trust_policy"
      ],
      "oc_removed" : [
        "encryption",
        "network_rule_set"
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
          "enable_free_tier",
          "free_tier_enabled"
        ],
        [
          "enable_automatic_failover",
          "automatic_failover_enabled"
        ],
        [
          "enable_multiple_write_locations",
          "multiple_write_locations_enabled"
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
        "automatic_channel_upgrade",
        "public_network_access_enabled",
        "enable_pod_security_policy",
        "node_os_channel_upgrade"
      ],
      "oc_removed" : [
        "api_server_access_profile"
      ],
      "renamed" : [
        [
          "api_server_authorized_ip_ranges",
          "authorized_ip_ranges` within the `api_server_access_profile"
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
    "azurerm_linux_virtual_machine_scale_set" : {
      "resource_type" : "azurerm_linux_virtual_machine_scale_set",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "gallery_applications",
          "gallery_application"
        ],
        [
          "terminate_notification",
          "termination_notification"
        ],
        [
          "scale_in_policy",
          "scale_in"
        ]
      ]
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
        "hourly_schedule",
        "monthly_schedule",
        "daily_schedule",
        "weekly_schedule"
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
          "enable_express",
          "express_enabled"
        ],
        [
          "enable_batched_operations",
          "batched_operations_enabled"
        ],
        [
          "enable_partitioning",
          "partitioning_enabled"
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
        "batched_operations_enabled",
        "partitioning_enabled",
        "express_enabled"
      ],
      "renamed" : [
        [
          "enable_express",
          "express_enabled"
        ],
        [
          "enable_batched_operations",
          "batched_operations_enabled"
        ],
        [
          "enable_partitioning",
          "partitioning_enabled"
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
      "deleted" : null,
      "oc_removed" : [
        "network_interface"
      ],
      "renamed" : null
    },
    "azurerm_site_recovery_replication_recovery_plan" : {
      "resource_type" : "azurerm_site_recovery_replication_recovery_plan",
      "deleted" : null,
      "oc_removed" : [
        "shutdown_recovery_group",
        "failover_recovery_group",
        "boot_recovery_group"
      ],
      "renamed" : [
        [
          "recovery_group",
          "shutdown_recovery_group`, `failover_recovery_group` and `boot_recovery_group"
        ]
      ]
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
          "private_endpoint_network_policies_enabled",
          "private_endpoint_network_policies"
        ],
        [
          "enforce_private_link_service_network_policies",
          "private_link_service_network_policies_enabled"
        ],
        [
          "enforce_private_link_endpoint_network_policies",
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
        "sql_aad_admin",
        "aad_admin"
      ],
      "oc_removed" : null,
      "renamed" : null
    },
    "azurerm_virtual_network" : {
      "resource_type" : "azurerm_virtual_network",
      "deleted" : null,
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
        "external_mapping",
        "internal_mapping"
      ],
      "renamed" : [
        [
          "internal_address_space_mappings",
          "internal_mapping"
        ],
        [
          "external_address_space_mappings",
          "external_mapping"
        ]
      ]
    },
    "azurerm_windows_virtual_machine_scale_set" : {
      "resource_type" : "azurerm_windows_virtual_machine_scale_set",
      "deleted" : null,
      "oc_removed" : null,
      "renamed" : [
        [
          "terminate_notification",
          "termination_notification"
        ],
        [
          "gallery_applications",
          "gallery_application"
        ],
        [
          "scale_in_policy",
          "scale_in"
        ]
      ]
    }
  }
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
    from = i[0]
    to = i[1]
  }])])
  enable_to_enabled_blocks = toset(flatten([
    for k, v in local.all_resources : [
      for obj in local.flatten_enable_to_enabled : {
        block_address = k
        mptf = v.mptf
        from = obj.from
        to = obj.to
      } if v.mptf.block_labels[0] == obj.resource_type
    ]
  ]))
}

transform "update_in_place" oc_removed {
  for_each             = try(local.oc_removed_addresses, [])
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

transform "remove_block_content" attribute_removed {
  for_each             = try(local.attribute_removed_addresses, [])
  target_block_address = each.value
  paths                = local.diffs[local.all_resources[each.value].mptf.block_labels[0]].deleted
}
