locals {
  vpn_gateway_nat_rule_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_vpn_gateway_nat_rule"]) : [for b in blocks : b]])
  vpn_gateway_nat_rule_resource_blocks_map = { for block in local.vpn_gateway_nat_rule_resource_blocks : block.mptf.block_address => block }
  vpn_gateway_nat_rule_with_external_address_space_mappings = {
    for key, block in local.vpn_gateway_nat_rule_resource_blocks_map : key => block if can(block.external_address_space_mappings) && !can(block.external_mapping)
  }
  vpn_gateway_nat_rule_with_internal_address_space_mappings = {
    for key, block in local.vpn_gateway_nat_rule_resource_blocks_map : key => block if can(block.internal_address_space_mappings) && !can(block.internal_mapping)
  }
}

transform "update_in_place" vpn_gateway_nat_rule_with_external_address_space_mappings {
  for_each             = var.azurerm_vpn_gateway_nat_rule_toggle ? local.vpn_gateway_nat_rule_with_external_address_space_mappings : tomap({})
  target_block_address = each.key
  asstring {
    dynamic "external_mapping" {
      for_each = each.value.external_address_space_mappings
      content {
        address_space = "external_mapping.value"
      }
    }
  }
}

transform "update_in_place" vpn_gateway_nat_rule_with_internal_address_space_mappings {
  for_each             = var.azurerm_vpn_gateway_nat_rule_toggle ? local.vpn_gateway_nat_rule_with_internal_address_space_mappings : tomap({})
  target_block_address = each.key
  asstring {
    dynamic "internal_mapping" {
      for_each = each.value.internal_address_space_mappings
      content {
        address_space = "internal_mapping.value"
      }
    }
  }
  depends_on = [
    transform.update_in_place.vpn_gateway_nat_rule_with_external_address_space_mappings,
  ]
}

transform "remove_block_element" vpn_gateway_nat_rule {
  for_each             = var.azurerm_vpn_gateway_nat_rule_toggle ? local.vpn_gateway_nat_rule_resource_blocks_map : tomap({})
  target_block_address = each.key
  paths                = ["external_address_space_mappings", "internal_address_space_mappings"]
  depends_on = [
    transform.update_in_place.vpn_gateway_nat_rule_with_internal_address_space_mappings,
  ]
}

transform "regex_replace_expression" vpn_gateway_nat_rule {
  for_each = var.azurerm_vpn_gateway_nat_rule_toggle ? tomap({
    "external_address_space_mappings" : "external_mapping",
    "internal_address_space_mappings" : "internal_mapping",
  }) : tomap({})
  regex       = "azurerm_vpn_gateway_nat_rule\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${each.key}"
  replacement = "(azurerm_vpn_gateway_nat_rule.$${1}$${2}$${3}$${4}$${5}${each.value}[*].address_space)"
}
