locals {
  managed_application_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_managed_application"]) : [for b in blocks : b]])
  managed_application_resource_blocks_map = { for block in local.managed_application_resource_blocks : block.mptf.block_address => block }
  managed_application_with_parameters_only = {
    for key, block in local.managed_application_resource_blocks_map : key => block if can(block.parameters) && !can(block.parameter_values)
  }
}

transform "update_in_place" managed_application {
  for_each             = var.azurerm_managed_application_toggle ? local.managed_application_with_parameters_only : tomap({})
  target_block_address = each.key
  asstring {
    parameter_values = "jsonencode({ for k,v in ${each.value.parameters} : k => { value = v}})"
  }
}

transform "remove_block_element" managed_application {
  for_each             = var.azurerm_managed_application_toggle ? local.managed_application_with_parameters_only : tomap({})
  target_block_address = each.key
  paths                = ["parameters"]
  depends_on = [
    transform.update_in_place.managed_application,
  ]
}

transform regex_replace_expression managed_application_parameters {
  for_each    = var.azurerm_managed_application_toggle ? ["managed_application_parameters"] : []
  regex       = "azurerm_managed_application\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?parameters"
  replacement = "({ for k,v in jsondecode(azurerm_managed_application.$${1}$${2}$${3}$${4}$${5}parameter_values) : k => v.value})"
}