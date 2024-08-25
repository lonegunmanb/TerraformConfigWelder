locals {
  windows_web_app_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_windows_web_app"]) : [for b in blocks : b]])
  windows_web_app_resource_blocks_map = { for block in local.windows_web_app_resource_blocks : block.mptf.block_address => block }
  windows_web_app_with_external_address_space_mappings = {
    for key, block in local.windows_web_app_resource_blocks_map : key => block if can(block.external_address_space_mappings) && !can(block.external_mapping)
  }
  windows_web_app_with_internal_address_space_mappings = {
    for key, block in local.windows_web_app_resource_blocks_map : key => block if can(block.internal_address_space_mappings) && !can(block.internal_mapping)
  }
}
