resource "azurerm_cdn_endpoint" "example" {
  location            = azurerm_resource_group.example.location
  name                = "example"
  profile_name        = azurerm_cdn_profile.example.name
  resource_group_name = azurerm_resource_group.example.name

  origin {
    host_name = "www.contoso.com"
    name      = "example"
  }

  lifecycle {
    ignore_changes = [content_types_to_compress, origin_path, probe_path]
  }
}