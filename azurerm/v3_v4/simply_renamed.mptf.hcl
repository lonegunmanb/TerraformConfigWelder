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
      } : [
      for rename in renames : {
        resource_type = resource_type
        from          = rename.from
        to            = rename.to
        replace_ref   = rename.replace_ref
      }
    ]
  ])
}


transform rename_block_element simply_renamed {
  for_each = var.simply_renamed_toggle ? ["simply_renamed"] : []
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
  for_each    = var.simply_renamed_toggle ? [for rename in local.rename_with_replacement : rename] : []
  regex       = each.value.regex
  replacement = each.value.replacement
  depends_on = [
    transform.regex_replace_expression.azurerm_linux_virtual_machine_scale_set_gallery_application,
  ]
}