locals {
  sentinel_log_analytics_workspace_onboarding_resource_blocks = flatten([
    for _, blocks in flatten([
      for resource_type, resource_blocks in data.resource.all.result : resource_blocks
      if resource_type == "azurerm_sentinel_log_analytics_workspace_onboarding"
    ]) : [for b in blocks : b]
  ])
  sentinel_log_analytics_workspace_onboarding_resource_blocks_map = {
    for block in local.sentinel_log_analytics_workspace_onboarding_resource_blocks : block.mptf.block_address => block
  }
  sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name = {
    for key, block in local.sentinel_log_analytics_workspace_onboarding_resource_blocks_map : key => block if can(block.workspace_name) && can(block.resource_group_name)
  }
  sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_count = {
    for key, block in local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name : key => block if can(block.count)
  }
  sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_for_each = {
    for key, block in local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name : key => block if can(block.for_each)
  }
  sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton = {
    for key, block in local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name : key => block if !can(block.for_each) && !can(block.count)
  }
}

transform "new_block" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton_data_source {
  for_each       = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton : tomap({})
  new_block_type = "data"
  filename       = each.value.mptf.range.file_name
  labels         = ["azurerm_log_analytics_workspace", each.value.mptf.block_labels[1]]
  asstring {
    name                = each.value.workspace_name
    resource_group_name = each.value.resource_group_name
    provider            = try(each.value.provider, "azurerm")
  }
}

transform "update_in_place" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton {
  for_each             = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton : tomap({})
  target_block_address = each.key
  asstring {
    workspace_id = "data.azurerm_log_analytics_workspace.${each.value.mptf.block_labels[1]}.workspace_id"
  }
  depends_on = [
    transform.new_block.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton_data_source,
  ]
}

transform "remove_block_element" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton {
  for_each             = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton : tomap({})
  target_block_address = each.key
  paths                = ["workspace_name"]
  depends_on = [
    transform.update_in_place.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton,
  ]
}

transform "new_block" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_count_data_source {
  for_each       = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_count : tomap({})
  new_block_type = "data"
  filename       = each.value.mptf.range.file_name
  labels         = ["azurerm_log_analytics_workspace", each.value.mptf.block_labels[1]]
  asstring {
    count               = each.value.count
    name                = each.value.workspace_name
    resource_group_name = each.value.resource_group_name
    provider            = try(each.value.provider, "azurerm")
  }
  depends_on = [transform.remove_block_element.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_singleton]
}

transform "update_in_place" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_count {
  for_each             = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_count : tomap({})
  target_block_address = each.key
  asstring {
    workspace_id = "data.azurerm_log_analytics_workspace.${each.value.mptf.block_labels[1]}[count.index].workspace_id"
  }
  depends_on = [
    transform.new_block.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_count_data_source,
  ]
}

transform "remove_block_element" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_count {
  for_each             = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_count : tomap({})
  target_block_address = each.key
  paths                = ["workspace_name"]
  depends_on = [
    transform.update_in_place.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_count,
  ]
}

transform "new_block" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_for_each_data_source {
  for_each       = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_for_each : tomap({})
  new_block_type = "data"
  filename       = each.value.mptf.range.file_name
  labels         = ["azurerm_log_analytics_workspace", each.value.mptf.block_labels[1]]
  asstring {
    for_each            = each.value.for_each
    name                = each.value.workspace_name
    resource_group_name = each.value.resource_group_name
    provider            = try(each.value.provider, "azurerm")
  }
  depends_on = [transform.remove_block_element.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_count]
}

transform "update_in_place" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_for_each {
  for_each             = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_for_each : tomap({})
  target_block_address = each.key
  asstring {
    workspace_id = "data.azurerm_log_analytics_workspace.${each.value.mptf.block_labels[1]}[each.key].workspace_id"
  }
  depends_on = [
    transform.new_block.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_for_each_data_source,
  ]
}

transform "remove_block_element" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_for_each {
  for_each             = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? local.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_and_for_each : tomap({})
  target_block_address = each.key
  paths                = ["workspace_name"]
  depends_on = [
    transform.update_in_place.sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group_name_for_each,
  ]
}

transform "regex_replace_expression" sentinel_log_analytics_workspace_onboarding_with_workspace_name_and_resource_group {
  for_each = var.azurerm_sentinel_log_analytics_workspace_onboarding_toggle ? tomap({
    "workspace_name" : "name",
    "resource_group_name" : "resource_group_name",
  }) : tomap({})
  regex       = "azurerm_sentinel_log_analytics_workspace_onboarding\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${each.key}"
  replacement = "data.azurerm_log_analytics_workspace.$${1}$${2}$${3}$${4}$${5}${each.value}"
}