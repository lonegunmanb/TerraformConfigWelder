resource "azurerm_bot_channel_web_chat" "example" {
  bot_name            = azurerm_bot_channels_registration.example.name
  location            = azurerm_bot_channels_registration.example.location
  resource_group_name = azurerm_resource_group.example.name

  dynamic "site" {
    for_each = ["example", "example2"]

    content {
      name = site.value
    }
  }

  lifecycle {
    ignore_changes = [site]
  }
}