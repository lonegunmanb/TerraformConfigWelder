
locals {
  subnet_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_subnet"]) : [for b in blocks : b]])
  subnet_resource_blocks_map = { for block in local.subnet_resource_blocks : block.mptf.block_address => block }
  subnet_resource_addresses  = keys(local.subnet_resource_blocks_map)
  subnet_enforce_private_link_endpoint_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.enforce_private_link_endpoint_network_policies, "false")
  }
  subnet_enforce_private_link_service_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.enforce_private_link_service_network_policies, "false")
  }
  subnet_private_endpoint_network_policies_enabled = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.private_endpoint_network_policies_enabled, "false")
  }
  subnet_private_link_service_network_policies_enabled = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.private_link_service_network_policies_enabled, "!${block.enforce_private_link_service_network_policies}", "true")
  }
  subnet_private_endpoint_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => try(block.private_endpoint_network_policies, "null")
  }
  subnet_enforce = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.enforce_private_link_endpoint_network_policies)}!=null", "false")
  }
  subnet_enable = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.private_endpoint_network_policies_enabled)}!=null", "false")
  }
  subnet_enforce_service = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.enforce_private_link_service_network_policies)}!=null", "false")
  }
  subnet_enable_service = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.private_link_service_network_policies_enabled)}!=null", "false")
  }
  subnet_private_endpoint_network_policies_ok = {
    for key, block in local.subnet_resource_blocks_map : key => try("${tostring(block.private_endpoint_network_policies)}!=null", "false")
  }
  # enforceOk || enableOk || privateEndpointNetworkPoliciesOk
  subnet_enforce_or_enable_or_private_endpoint_network_policies = {
    for key, block in local.subnet_resource_blocks_map : key => join(" || ", [local.subnet_enforce[block.mptf.block_address], local.subnet_enable[block.mptf.block_address], local.subnet_private_endpoint_network_policies_ok[block.mptf.block_address]])
  }
  subnet_enforce_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.enforce_private_link_endpoint_network_policies, false)} ? (\"Disabled\") : (\"Enabled\")"
  }
  subnet_enable_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.private_endpoint_network_policies_enabled, false)} ? (\"Enabled\") : (\"Disabled\")"
  }
  subnet_private_endpoint_network_policies_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "${try(block.private_endpoint_network_policies, null)}"
  }
  subnet_private_endpoint_network_value = {
    for key, block in local.subnet_resource_blocks_map : key => "(${local.subnet_enforce_or_enable_or_private_endpoint_network_policies[block.mptf.block_address]}) ? ((${local.subnet_private_endpoint_network_policies_ok[block.mptf.block_address]}) ? (${local.subnet_private_endpoint_network_policies[block.mptf.block_address]}): ((${local.subnet_enable[block.mptf.block_address]}) ? (${local.subnet_enable_branch[block.mptf.block_address]}) : (${local.subnet_enforce_branch[block.mptf.block_address]}))) : (\"Enabled\")"
#     for key, block in local.subnet_resource_blocks_map : key => "(${local.subnet_enforce_or_enable_or_private_endpoint_network_policies[block.mptf.block_address]}) ? (${local.subnet_enable[block.mptf.block_address]} ? (${local.subnet_enable_branch[block.mptf.block_address]}) : ((${local.subnet_enforce[block.mptf.block_address]}) ? (${local.subnet_enforce_branch[block.mptf.block_address]}) : (${local.subnet_private_endpoint_network_policies[block.mptf.block_address]}))) : (\"Enabled\")"
  }
  subnet_enforce_service_branch = {
    for key, block in local.subnet_resource_blocks_map : key => "!${try(block.enforce_private_link_service_network_policies, false)}"
  }
  subnet_private_link_service_network_value = {
    for key, block in local.subnet_resource_blocks_map : key => "(${local.subnet_enforce_service[key]}) ? (${local.subnet_enforce_service_branch[key]}) : (true)"
  }
}

transform "update_in_place" subnet_private_endpoint_network_policies {
  for_each             = var.azurerm_subnet_toggle ? try(local.subnet_private_endpoint_network_value, tomap({})) : tomap({})
  target_block_address = each.key
  asstring {
    private_endpoint_network_policies = coalesce(try(local.subnet_resource_blocks_map[each.key].private_endpoint_network_policies, null), each.value)
  }
}

transform "update_in_place" subnet_private_link_service_network_policies {
  for_each             = var.azurerm_subnet_toggle ? try(local.subnet_private_link_service_network_value, tomap({})) : tomap({})
  target_block_address = each.key
  asstring {
    private_link_service_network_policies_enabled = coalesce(try(local.subnet_resource_blocks_map[each.key].private_link_service_network_policies_enabled, null), each.value)
  }
  depends_on = [
    transform.update_in_place.subnet_private_endpoint_network_policies,
  ]
}

locals {
  subnet_deprecated_attributes = [
    "private_endpoint_network_policies_enabled",
    "enforce_private_link_endpoint_network_policies",
    "enforce_private_link_service_network_policies",
  ]
}

transform "remove_block_element" subnet_deprecated_attributes {
  for_each             = var.azurerm_subnet_toggle ? local.subnet_resource_addresses : []
  target_block_address = each.value
  paths                = local.subnet_deprecated_attributes
  depends_on = [
    transform.update_in_place.subnet_private_link_service_network_policies,
  ]
}
