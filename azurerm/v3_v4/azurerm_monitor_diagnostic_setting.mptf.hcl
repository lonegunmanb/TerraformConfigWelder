locals {
  monitor_diagnostic_setting_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_monitor_diagnostic_setting"]) : [for b in blocks : b]])
  monitor_diagnostic_setting_resource_blocks_map = { for block in local.monitor_diagnostic_setting_resource_blocks : block.mptf.block_address => block }
  monitor_diagnostic_setting_with_log = {
    for key, block in local.monitor_diagnostic_setting_resource_blocks_map : key => block if can(block.log[0])
  }
  monitor_diagnostic_setting_with_enabled_log_retention_policy = {
    for key, block in local.monitor_diagnostic_setting_resource_blocks_map : key => block if can(block.enabled_log[0].retention_policy)
  }
  monitor_diagnostic_setting_with_metric_retention_policy = {
    for key, block in local.monitor_diagnostic_setting_resource_blocks_map : key => block if can(block.metric[0].retention_policy)
  }
}

transform "update_in_place" monitor_diagnostic_setting {
  for_each             = var.azurerm_monitor_diagnostic_setting_toggle ? local.monitor_diagnostic_setting_with_log : tomap({})
  target_block_address = each.key
  asstring {
    dynamic "enabled_log" {
      for_each = can(each.value.log[0].for_each) ? "try((${each.value.log[0].enabled}) ? { for k,v in (${each.value.log[0].for_each}) : k => v } : tomap({}), (${each.value.log[0].enabled}) ? (${each.value.log[0].for_each}) : toset([]), (${each.value.log[0].for_each}))" : try("(${each.value.log[0].enabled}) ? [\"enabled_log\"] : []", "[\"enabled_log\"]")
      iterator = try(each.value.log[0].iterator, "log")
      content {
        category       = try(each.value.log[0].category, "null")
        category_group = try(each.value.log[0].category_group, "null")
      }
    }
  }
  depends_on = [
    transform.remove_block_element.monitor_diagnostic_setting_log,
  ]
}

transform remove_block_element monitor_diagnostic_setting_log {
  for_each             = var.azurerm_monitor_diagnostic_setting_toggle ? local.monitor_diagnostic_setting_with_log : tomap({})
  target_block_address = each.key
  paths                = ["log"]
}

transform remove_block_element monitor_diagnostic_setting_enabled_log_retention_policy {
  for_each             = var.azurerm_monitor_diagnostic_setting_toggle ? local.monitor_diagnostic_setting_with_enabled_log_retention_policy : tomap({})
  target_block_address = each.key
  paths                = ["enabled_log.retention_policy"]
}

transform remove_block_element monitor_diagnostic_setting_metric_retention_policy {
  for_each             = var.azurerm_monitor_diagnostic_setting_toggle ? local.monitor_diagnostic_setting_with_metric_retention_policy : tomap({})
  target_block_address = each.key
  paths                = ["metric.retention_policy"]
}