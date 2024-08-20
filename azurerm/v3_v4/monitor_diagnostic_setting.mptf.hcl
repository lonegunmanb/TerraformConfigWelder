locals {
  monitor_diagnostic_setting_types              = toset(["azurerm_monitor_aad_diagnostic_setting", "azurerm_monitor_diagnostic_setting"])
  monitor_diagnostic_setting_resource_blocks    = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if contains(local.monitor_diagnostic_setting_types, resource_type)])
  monitor_diagnostic_setting_resource_mptfs     = flatten([for _, blocks in local.monitor_diagnostic_setting_resource_blocks : [for b in blocks : b.mptf]])
  monitor_diagnostic_setting_resource_addresses = [for mptf in local.monitor_diagnostic_setting_resource_mptfs : mptf.block_address]
}

transform remove_block_element monitor_diagnostic_setting {
  for_each             = var.monitor_diagnostic_setting_toggle ? local.monitor_diagnostic_setting_resource_addresses : []
  target_block_address = each.value
  paths                = ["log.enabled"]
}