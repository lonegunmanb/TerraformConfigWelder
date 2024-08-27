resource "azurerm_api_management_api" "example" {
  api_management_name = azurerm_api_management.example.name
  name                = "example-api"
  resource_group_name = azurerm_resource_group.example.name
  revision            = "1"
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]
  soap_pass_through   = var.soap_pass_through

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
}