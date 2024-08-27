resource "azurerm_bot_channels_registration" "example" {
  location                 = "global"
  microsoft_app_id         = data.azurerm_client_config.current.client_id
  name                     = "example"
  resource_group_name      = azurerm_resource_group.example.name
  sku                      = "F0"
  isolated_network_enabled = var.azurerm_bot_channels_registration_isolated_network_enabled
}

locals {
  azurerm_bot_channels_registration_isolated_network_enabled = azurerm_bot_channels_registration.example.isolated_network_enabled
}