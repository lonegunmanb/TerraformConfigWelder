locals {
  attribute_removed           = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if try(local.diffs[resource_type].deleted != null, false)])
  attribute_removed_mptfs     = flatten([for _, blocks in local.attribute_removed : [for b in blocks : b.mptf]])
  attribute_removed_addresses = [for mptf in local.attribute_removed_mptfs : mptf.block_address]
}

transform "remove_block_element" attribute_removed {
  for_each             = try(local.attribute_removed_addresses, [])
  target_block_address = each.value
  paths                = local.diffs[local.all_resources[each.value].mptf.block_labels[0]].deleted
  depends_on           = [transform.regex_replace_expression.simply_renamed]
}
