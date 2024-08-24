locals {
  simply_renamed = flatten([
    for resource_type, renames in {
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
      azurerm_cosmosdb_account = [
        {
          from        = "enable_multiple_write_locations"
          to          = "multiple_write_locations_enabled"
          replace_ref = true
        },
        {
          from        = "enable_free_tier"
          to          = "free_tier_enabled"
          replace_ref = true
        },
        {
          from        = "enable_automatic_failover"
          to          = "automatic_failover_enabled"
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
        {
          from        = "terminate_notification"
          to          = "termination_notification"
          replace_ref = true
        }
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
        },
        {
          from        = "automatic_channel_upgrade"
          to          = "automatic_upgrade_channel"
          replace_ref = true
        },
        {
          from        = "node_os_channel_upgrade"
          to          = "node_os_upgrade_channel"
          replace_ref = true
        },
        {
          from        = "default_node_pool.enable_auto_scaling"
          to          = "default_node_pool.auto_scaling_enabled"
          replace_ref = true
        }
      ]
      azurerm_kubernetes_cluster_node_pool = [
        {
          from        = "enable_auto_scaling"
          to          = "auto_scaling_enabled"
          replace_ref = true
        },
        {
          from        = "enable_node_public_ip"
          to          = "node_public_ip_enabled"
          replace_ref = true
        },
        {
          from        = "enable_host_encryption"
          to          = "host_encryption_enabled"
          replace_ref = true
        },
      ]
      azurerm_machine_learning_workspace = [
        {
          from        = "public_access_behind_virtual_network_enabled"
          to          = "public_network_access_enabled"
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
      azurerm_cdn_endpoint_custom_domain = [
        {
          from        = "user_managed_https.key_vault_certificate_id"
          to          = "key_vault_secret_id"
          replace_ref = true
        }
      ]
      azurerm_redis_cache = [
        {
          from        = "redis_configuration.enable_authentication"
          to          = "authentication_enabled"
          replace_ref = true
        }
      ]
      azurerm_sentinel_alert_rule_scheduled = [
        {
          from        = "incident_configuration.create_incident"
          to          = "create_incident_enabled"
          replace_ref = false
        },
        {
          from        = "incident_configuration.group_by_entities"
          to          = "by_entities"
          replace_ref = false
        },
        {
          from        = "incident_configuration.group_by_alert_details"
          to          = "by_alert_details"
          replace_ref = false
        },
        {
          from        = "incident_configuration.group_by_custom_details"
          to          = "by_custom_details"
          replace_ref = false
        },
      ]
      } : [
      for rename in renames : {
        resource_type = resource_type
        from          = rename.from
        to            = rename.to
        replace_ref   = rename.replace_ref
      }
    ]
  ])
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


transform rename_block_element simply_renamed {
  for_each = var.simply_renamed_toggle ? ["simply_renamed"] : []
  dynamic "rename" {
    for_each = local.simply_renamed
    content {
      resource_type               = rename.value.resource_type
      attribute_path              = split(".", rename.value.from)
      new_name                    = rename.value.to
      rename_only_new_name_absent = true
    }
  }
  depends_on = [
    transform.remove_block_element.monitor_diagnostic_setting,
    transform.regex_replace_expression.simply_renamed,
    transform.update_in_place.oc_removed,
  ]
}

transform regex_replace_expression simply_renamed {
  for_each    = var.simply_renamed_toggle ? [for rename in local.rename_with_replacement : rename] : []
  regex       = each.value.regex
  replacement = each.value.replacement
  depends_on = [
    transform.regex_replace_expression.azurerm_linux_virtual_machine_scale_set_gallery_application,
  ]
}