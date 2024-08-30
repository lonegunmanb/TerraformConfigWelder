locals {
  route_table_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_route_table"]) : [for b in blocks : b]])
  route_table_resource_blocks_map = { for block in local.route_table_resource_blocks : block.mptf.block_address => block }
  route_table_with_disable_bgp_route_propagation = {
    for key, block in local.route_table_resource_blocks_map : key => block if can(block.disable_bgp_route_propagation)
  }
}

transform "update_in_place" route_table_disable_bgp_route_propagation {
  for_each             = var.azurerm_route_table_toggle ? local.route_table_with_disable_bgp_route_propagation : tomap({})
  target_block_address = each.key
  asstring {
    bgp_route_propagation_enabled = "!(${each.value.disable_bgp_route_propagation})"
  }
}

transform "remove_block_element" route_table_disable_bgp_route_propagation {
  for_each             = var.azurerm_route_table_toggle ? local.route_table_with_disable_bgp_route_propagation : tomap({})
  target_block_address = each.key
  paths                = ["disable_bgp_route_propagation"]
  depends_on = [
    transform.update_in_place.route_table_disable_bgp_route_propagation,
  ]
}

transform regex_replace_expression route_table_disable_bgp_route_propagation {
  for_each    = var.azurerm_route_table_toggle ? ["route_table_disable_bgp_route_propagation"] : []
  regex       = "azurerm_route_table\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?disable_bgp_route_propagation"
  replacement = "(!(azurerm_route_table.$${1}$${2}$${3}$${4}$${5}bgp_route_propagation_enabled))"
}