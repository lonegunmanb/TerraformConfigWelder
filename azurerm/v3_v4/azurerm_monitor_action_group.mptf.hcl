locals {
  monitor_action_group_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_monitor_action_group"]) : [for b in blocks : b]])
  monitor_action_group_resource_blocks_map = { for block in local.monitor_action_group_resource_blocks : block.mptf.block_address => block }
  monitor_action_group_with_event_hub_receiver = {
    for key, block in local.monitor_action_group_resource_blocks_map : key => block if can(block.event_hub_receiver)
  }
}

//TODO: currently `update_in_place` does not support multiple target nested blocks patch with different configs.