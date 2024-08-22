locals {
  linux_virtual_machine_scale_set_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_linux_virtual_machine_scale_set"]) : [for b in blocks : b]])
  linux_virtual_machine_scale_set_resource_blocks_map = { for block in local.linux_virtual_machine_scale_set_resource_blocks : block.mptf.block_address => block }
  linux_virtual_machine_scale_set_with_scale_in_policy_only = {
    for key, block in local.linux_virtual_machine_scale_set_resource_blocks_map : key => block if try(tostring(block.scale_in_policy) != null, false) && !can(block.scale_in)
  }
}

transform regex_replace_expression azurerm_linux_virtual_machine_scale_set_gallery_application {
  for_each = var.azurerm_linux_virtual_machine_scale_set_toggle ? tomap({
    "package_reference_id" : "version_id",
    "configuration_reference_blob_uri" : "configuration_blob_uri",
  }) : tomap({})
  regex       = "azurerm_linux_virtual_machine_scale_set\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?gallery_applications((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?${each.key}"
  replacement = "azurerm_linux_virtual_machine_scale_set.$${1}$${2}$${3}$${4}$${5}gallery_application$${6}$${7}$${8}${each.value}"
}

transform "update_in_place" azurerm_linux_virtual_machine_scale_set_gallery_application_scale_in {
  for_each             = var.azurerm_linux_virtual_machine_scale_set_toggle ? local.linux_virtual_machine_scale_set_with_scale_in_policy_only : tomap({})
  target_block_address = each.key
  asstring {
    scale_in {
      rule = each.value.scale_in_policy
    }
  }
  depends_on = [transform.regex_replace_expression.azurerm_linux_virtual_machine_scale_set_gallery_application]
}

transform regex_replace_expression azurerm_linux_virtual_machine_scale_set_gallery_application_scale_in {
  for_each    = var.azurerm_linux_virtual_machine_scale_set_toggle ? ["azurerm_linux_virtual_machine_scale_set_gallery_application_scale_in"] : []
  regex       = "azurerm_linux_virtual_machine_scale_set\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?scale_in_policy"
  replacement = "azurerm_linux_virtual_machine_scale_set.$${1}$${2}$${3}$${4}$${5}scale_in[0].rule"
  depends_on  = [transform.update_in_place.azurerm_linux_virtual_machine_scale_set_gallery_application_scale_in]
}