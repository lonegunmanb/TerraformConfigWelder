locals {
  monitor_aad_diagnostic_setting_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_monitor_aad_diagnostic_setting"]) : [for b in blocks : b]])
  monitor_aad_diagnostic_setting_resource_blocks_map = { for block in local.monitor_aad_diagnostic_setting_resource_blocks : block.mptf.block_address => block }
  monitor_aad_diagnostic_setting_with_log = {
    for key, block in local.monitor_aad_diagnostic_setting_resource_blocks_map : key => block if can(block.log[0])
  }
}

transform "update_in_place" monitor_aad_diagnostic_setting {
  for_each             = var.azurerm_monitor_aad_diagnostic_setting_toggle ? local.monitor_aad_diagnostic_setting_with_log : tomap({})
  target_block_address = each.key
  asstring {
    dynamic "enabled_log" {
      for_each = can(each.value.log[0].for_each) ? "try((${each.value.log[0].enabled}) ? { for k,v in (${each.value.log[0].for_each}) : k => v } : tomap({}), (${each.value.log[0].enabled}) ? (${each.value.log[0].for_each}) : toset([]), (${each.value.log[0].for_each}))" : try("(${each.value.log[0].enabled}) ? [\"enabled_log\"] : []", "[\"enabled_log\"]")
      iterator = try(each.value.log[0].iterator, "log")
      content {
        category = try(each.value.log[0].category, "null")
        dynamic "retention_policy" {
          for_each = try(each.value.log[0].retention_policy[0].for_each, (can(each.value.log[0].retention_policy[0]) ? "[\"retention_policy\"]" : "[]"))
          iterator = try(each.value.log[0].retention_policy[0].iterator, "retention_policy")
          content {
            enabled = try(each.value.log[0].retention_policy[0].enabled, "null")
            days    = try(each.value.log[0].retention_policy[0].days, "null")
          }
        }
      }
    }
  }
  depends_on = [
    transform.remove_block_element.monitor_aad_diagnostic_setting,
  ]
}

transform "remove_block_element" monitor_aad_diagnostic_setting {
  for_each             = var.azurerm_monitor_aad_diagnostic_setting_toggle ? local.monitor_aad_diagnostic_setting_with_log : tomap({})
  target_block_address = each.key
  paths                = ["log"]
}

transform regex_replace_expression monitor_aad_diagnostic_setting {
  for_each    = var.azurerm_monitor_aad_diagnostic_setting_toggle ? ["azurerm_monitor_aad_diagnostic_setting_toggle"] : []
  regex       = "azurerm_monitor_aad_diagnostic_setting\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\n\\s*)?log"
  replacement = "azurerm_monitor_aad_diagnostic_setting.$${1}$${2}$${3}$${4}$${5}enabled_log"
  depends_on = [
    transform.rename_block_element.simply_renamed,
  ]
}