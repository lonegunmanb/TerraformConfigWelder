locals {
  container_registry_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_container_registry"]) : [for b in blocks : b]])
  container_registry_resource_blocks_map = { for block in local.container_registry_resource_blocks : block.mptf.block_address => block }
  container_registry_with_regention_policy_dot_days_only = {
    for key, block in local.container_registry_resource_blocks_map : key => block if try(block.retention_policy != null, false) && !can(block.retention_policy_in_days)
  }
  container_registry_with_trust_policy_only = {
    for key, block in local.container_registry_resource_blocks_map : key => block if try(block.retention_policy != null, false) && !can(block.trust_policy_enabled)
  }
}

transform "update_in_place" container_registry_with_regention_policy_dot_days_only {
  for_each             = var.azurerm_container_registry_toggle ? local.container_registry_with_regention_policy_dot_days_only : tomap({})
  target_block_address = each.key
  asstring {
    retention_policy_in_days = local.container_registry_resource_blocks_map[each.key].retention_policy[0].days
  }
}

transform "remove_block_element" container_registry_with_regention_policy_dot_days_only {
  for_each             = var.azurerm_container_registry_toggle ? local.container_registry_with_regention_policy_dot_days_only : tomap({})
  target_block_address = each.key
  paths                = ["retention_policy"]
  depends_on = [
    transform.update_in_place.container_registry_with_regention_policy_dot_days_only,
  ]
}

transform regex_replace_expression container_registry_with_regention_policy_dot_days_only {
  for_each    = var.azurerm_container_registry_toggle ? ["container_registry_with_regention_policy_dot_days_only"] : []
  regex       = "azurerm_container_registry\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?retention_policy((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?days"
  replacement = "azurerm_container_registry.$${1}$${2}$${3}$${4}$${5}retention_policy_in_days"
  depends_on = [
    transform.remove_block_element.container_registry_with_regention_policy_dot_days_only,
  ]
}

transform "update_in_place" container_registry_with_trust_policy_only {
  for_each             = var.azurerm_container_registry_toggle ? local.container_registry_with_trust_policy_only : tomap({})
  target_block_address = each.key
  asstring {
    trust_policy_enabled = local.container_registry_resource_blocks_map[each.key].trust_policy[0].enabled
  }
  depends_on = [
    transform.regex_replace_expression.container_registry_with_regention_policy_dot_days_only
  ]
}

transform "remove_block_element" container_registry_with_trust_policy_only {
  for_each             = var.azurerm_container_registry_toggle ? local.container_registry_with_trust_policy_only : tomap({})
  target_block_address = each.key
  paths                = ["trust_policy"]
  depends_on = [
    transform.update_in_place.container_registry_with_trust_policy_only,
  ]
}

transform regex_replace_expression container_registry_with_trust_policy_only {
  for_each    = var.azurerm_container_registry_toggle ? ["container_registry_with_trust_policy_only"] : []
  regex       = "azurerm_container_registry\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?trust_policy((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?enabled"
  replacement = "azurerm_container_registry.$${1}$${2}$${3}$${4}$${5}trust_policy_enabled"
  depends_on = [
    transform.remove_block_element.container_registry_with_trust_policy_only,
  ]
}