locals {
  attribute_removed_bypass = {
    azurerm_cdn_endpoint_custom_domain = toset(
      ["user_managed_https.key_vault_certificate_id"]
    )
  }
  attribute_removed     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if try(local.diffs[resource_type].deleted != null, false)]) : [for b in blocks : b]])
  attribute_removed_map = { for block in local.attribute_removed : block.mptf.block_address => block }
}

transform "remove_block_element" attribute_removed {
  for_each             = var.attribute_removed_toggle ? try(local.attribute_removed_map, {}) : tomap({})
  target_block_address = each.key
  paths                = try(setsubtract(local.diffs[each.value.mptf.block_labels[0]].deleted, local.attribute_removed_bypass[each.value.mptf.block_labels[0]]), local.diffs[each.value.mptf.block_labels[0]].deleted)
  depends_on           = [transform.regex_replace_expression.simply_renamed]
}
