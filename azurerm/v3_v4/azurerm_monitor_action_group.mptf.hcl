locals {
  monitor_action_group_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_monitor_action_group"]) : [for b in blocks : b]])
  monitor_action_group_resource_blocks_map = { for block in local.monitor_action_group_resource_blocks : block.mptf.block_address => block }
  monitor_action_group_with_event_hub_receiver = {
    for key, block in local.monitor_action_group_resource_blocks_map : key => block if anytrue([for receiver in block.event_hub_receiver : can(receiver.event_hub_id)])
  }
}

transform "remove_block_element" monitor_action_group_event_hub_receiver_with_event_hub_id {
  for_each             = var.azurerm_monitor_action_group_toggle ? local.monitor_action_group_with_event_hub_receiver : {}
  target_block_address = each.key
  paths                = ["event_hub_receiver"]
}

transform "append_block_body" monitor_action_group_event_hub_receiver_with_event_hub_id {
  for_each             = var.azurerm_monitor_action_group_toggle ? local.monitor_action_group_with_event_hub_receiver : {}
  target_block_address = each.key
  block_body = join("\n", [
    for receiver in each.value.event_hub_receiver :
    try(replace(receiver.mptf.tostring, "/event_hub_id(\\s*=\\s*)([\\s\\S]*?)(\n\\s*\\w+\\s*=)/", "event_hub_name = split(\"/\",${receiver.event_hub_id})[10]\nevent_hub_namespace = split(\"/\", ${receiver.event_hub_id})[8]\n$${3}"), receiver.mptf.tostring)
  ])
  depends_on = [transform.remove_block_element.monitor_action_group_event_hub_receiver_with_event_hub_id]
}
