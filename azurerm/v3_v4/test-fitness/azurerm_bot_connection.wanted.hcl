resource "azurerm_bot_connection" "example" {
  bot_name              = azurerm_bot_channels_registration.example.name
  client_id             = "exampleId"
  client_secret         = "exampleSecret"
  location              = azurerm_bot_channels_registration.example.location
  name                  = "example"
  resource_group_name   = azurerm_resource_group.example.name
  service_provider_name = "box"
}