locals {
  sentinel_alert_rule_scheduled_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_sentinel_alert_rule_scheduled"]) : [for b in blocks : b]])
  sentinel_alert_rule_scheduled_resource_blocks_map = { for block in local.route_table_resource_blocks : block.mptf.block_address => block }
  sentinel_alert_rule_scheduled_with_incident_configuration = {
    for key, block in local.route_table_resource_blocks_map : key => block if can(block.disable_bgp_route_propagation)
  }
  sentinel_alert_rule_scheduled_incident_configuration_replace = toset([
    {
      from = "create_incident"
      to   = "create_incident_enabled"
    },
    {
      from = "group_by_entities"
      to   = "by_entities"
    },
    {
      from = "group_by_alert_details"
      to   = "by_alert_details"
    },
    {
      from = "group_by_custom_details"
      to   = "by_custom_details"
    },
  ])
}

transform "regex_replace_expression" sentinel_alert_rule_scheduled_incident_configuration {
  for_each    = var.azurerm_sentinel_alert_rule_scheduled_toggle ? local.sentinel_alert_rule_scheduled_incident_configuration_replace : toset([])
  regex       = "azurerm_sentinel_alert_rule_scheduled\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?incident_configuration((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?${each.value.from}"
  replacement = "azurerm_sentinel_alert_rule_scheduled.$${1}$${2}$${3}$${4}$${5}incident$${6}$${7}$${8}${each.value.to}"
}

transform "rename_block_element" sentinel_alert_rule_scheduled_incident_configuration_attributes {
  for_each = var.azurerm_sentinel_alert_rule_scheduled_toggle ? ["sentinel_alert_rule_scheduled_incident_configuration_replace"] : []
  dynamic "rename" {
    for_each = local.sentinel_alert_rule_scheduled_incident_configuration_replace
    content {
      resource_type               = "azurerm_sentinel_alert_rule_scheduled"
      attribute_path              = ["incident_configuration.${rename.value.from}"]
      new_name                    = rename.value.to
      rename_only_new_name_absent = true
    }
  }
  depends_on = [transform.regex_replace_expression.sentinel_alert_rule_scheduled_incident_configuration]
}

transform "rename_block_element" sentinel_alert_rule_scheduled_incident_configuration_block {
  for_each = var.azurerm_sentinel_alert_rule_scheduled_toggle ? ["sentinel_alert_rule_scheduled_incident_configuration_replace"] : []
  rename {
    resource_type               = "azurerm_sentinel_alert_rule_scheduled"
    attribute_path              = ["incident_configuration"]
    new_name                    = "incident"
    rename_only_new_name_absent = true
  }
  depends_on = [transform.rename_block_element.sentinel_alert_rule_scheduled_incident_configuration_attributes]
}