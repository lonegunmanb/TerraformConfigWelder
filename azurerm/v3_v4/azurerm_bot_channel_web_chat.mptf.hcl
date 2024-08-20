locals {
  bot_channel_web_chat_resource_blocks = flatten([
    for _, blocks in flatten([
      for resource_type, resource_blocks in data.resource.all.result : resource_blocks
      if resource_type == "azurerm_bot_channel_web_chat"
    ]) : [for b in blocks : b]
  ])
  bot_channel_web_chat_resource_blocks_with_site_names_only = [
    for block in local.bot_channel_web_chat_resource_blocks :block if can(block.site_names != "") && !can(block.site[0])
  ]
  bot_channel_web_chat_resource_blocks_map                  = {
    for block in local.bot_channel_web_chat_resource_blocks_with_site_names_only : block.mptf.block_address => block
  }
}

transform "update_in_place" bot_channel_web_chat {
  for_each             = var.azurerm_bot_channel_web_chat_toggle ? local.bot_channel_web_chat_resource_blocks_map : {}
  target_block_address = each.key
  asstring {
    dynamic "site" {
      for_each = each.value.site_names
      content {
        name = "site.value"
      }
    }
  }
}

transform "remove_block_element" bot_channel_web_chat {
  for_each             = var.azurerm_bot_channel_web_chat_toggle ? local.bot_channel_web_chat_resource_blocks_map : {}
  target_block_address = each.key
  paths = ["site_names"]
  depends_on = [
    transform.update_in_place.bot_channel_web_chat,
  ]
}