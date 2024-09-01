locals {
  signalr_service_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_signalr_service"]) : [for b in blocks : b]])
  signalr_service_resource_blocks_map = { for block in local.signalr_service_resource_blocks : block.mptf.block_address => block }
  signalr_service_with_live_trace_enabled = {
    for key, block in local.signalr_service_resource_blocks_map : key => block if can(block.live_trace_enabled) && !can(block.live_trace)
  }
}

transform "update_in_place" signalr_service {
  for_each             = var.azurerm_signalr_service_toggle ? local.signalr_service_with_live_trace_enabled : tomap({})
  target_block_address = each.key
  asstring {
    live_trace {
      enabled = each.value.live_trace_enabled
    }
  }
  depends_on = [
    transform.update_in_place.signalr_service,
  ]
}

transform "remove_block_element" signalr_service {
  for_each             = var.azurerm_signalr_service_toggle ? local.signalr_service_with_live_trace_enabled : tomap({})
  target_block_address = each.key
  paths                = ["live_trace_enabled"]
}

transform regex_replace_expression signalr_service {
  for_each    = var.azurerm_signalr_service_toggle ? ["signalr_service"] : []
  regex       = "azurerm_signalr_service\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?live_trace_enabled"
  replacement = "(try(azurerm_managed_application.$${1}$${2}$${3}$${4}$${5}live_trace[0].enabled, false))"
}