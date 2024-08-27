resource "azurerm_api_management_api" "example" {
  api_management_name = azurerm_api_management.example.name
  name                = "example-api"
  resource_group_name = azurerm_resource_group.example.name
  revision            = "1"
  api_type            = ((var.soap_pass_through) == null) ? ("http") : ((var.soap_pass_through) ? "soap" : "http")
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
}