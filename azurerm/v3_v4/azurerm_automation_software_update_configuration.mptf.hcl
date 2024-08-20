locals {
  automation_software_update_configuration_blocks                                               = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_automation_software_update_configuration"]) : [for b in blocks : b]])
  automation_software_update_configuration_blocks_with_linux_classification_included_only       = [for block in local.automation_software_update_configuration_blocks : block if try(block.linux[0].classification_included != "", false) && !can(block.linux[0].classifications_included)]
  automation_software_update_configuration_blocks_with_windows_classification_included_only     = [for block in local.automation_software_update_configuration_blocks : block if try(block.windows[0].classification_included != "", false) && !can(block.windows[0].classifications_included)]
  automation_software_update_configuration_blocks_with_linux_classification_included_only_map   = { for block in local.automation_software_update_configuration_blocks_with_linux_classification_included_only : block.mptf.block_address => block }
  automation_software_update_configuration_blocks_with_windows_classification_included_only_map = { for block in local.automation_software_update_configuration_blocks_with_windows_classification_included_only : block.mptf.block_address => block }
}

transform "update_in_place" automation_software_update_configuration_linux_classification_included_only {
  for_each             = var.azurerm_automation_software_update_configuration_toggle ? local.automation_software_update_configuration_blocks_with_linux_classification_included_only_map : {}
  target_block_address = each.key
  asstring {
    linux {
      classifications_included = "[${each.value.linux[0].classification_included}]"
    }
  }
}

transform "update_in_place" automation_software_update_configuration_windows_classification_included_only {
  for_each             = var.azurerm_automation_software_update_configuration_toggle ? local.automation_software_update_configuration_blocks_with_windows_classification_included_only_map : {}
  target_block_address = each.key
  asstring {
    windows {
      classifications_included = "[${each.value.windows[0].classification_included}]"
    }
  }
}

transform "remove_block_element" automation_software_update_configuration_linux {
  for_each             = var.azurerm_automation_software_update_configuration_toggle ? local.automation_software_update_configuration_blocks_with_linux_classification_included_only_map : {}
  target_block_address = each.key
  paths                = ["linux.classification_included"]
  depends_on = [
    transform.update_in_place.automation_software_update_configuration_linux_classification_included_only,
    transform.update_in_place.automation_software_update_configuration_windows_classification_included_only,
  ]
}

transform "remove_block_element" automation_software_update_configuration_windows {
  for_each             = var.azurerm_automation_software_update_configuration_toggle ? local.automation_software_update_configuration_blocks_with_windows_classification_included_only_map : {}
  target_block_address = each.key
  paths                = ["windows.classification_included"]
  depends_on = [
    transform.update_in_place.automation_software_update_configuration_linux_classification_included_only,
    transform.update_in_place.automation_software_update_configuration_windows_classification_included_only,
  ]
}