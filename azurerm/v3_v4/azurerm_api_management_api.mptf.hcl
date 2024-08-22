locals {
  api_management_api_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_api_management_api"]) : [for b in blocks : b]])
  api_management_api_resource_blocks_map = { for block in local.api_management_api_resource_blocks : block.mptf.block_address => block }
  api_management_api_resource_addresses  = keys(local.api_management_api_resource_blocks_map)
  api_management_api_with_soap_pass_through = {
    for key, block in local.api_management_api_resource_blocks_map : key => block if try(tostring(block.soap_pass_through) != null, false)
  }
}

transform "update_in_place" api_management_api_with_soap_pass_through {
  for_each             = var.azurerm_api_management_api_toggle ? local.api_management_api_with_soap_pass_through : tomap({})
  target_block_address = each.key
  asstring {
    api_type = coalesce(try(local.api_management_api_resource_blocks_map[each.key].api_type, null), "((${local.api_management_api_resource_blocks_map[each.key].soap_pass_through}) == null) ? (\"http\") : ((${local.api_management_api_resource_blocks_map[each.key].soap_pass_through}) ? \"soap\" : \"http\")")
  }
}

transform "remove_block_element" api_management_api_with_soap_pass_through {
  for_each             = var.azurerm_api_management_api_toggle ? local.api_management_api_with_soap_pass_through : tomap({})
  target_block_address = each.key
  paths                = ["soap_pass_through"]
  depends_on = [
    transform.update_in_place.api_management_api_with_soap_pass_through,
  ]
}