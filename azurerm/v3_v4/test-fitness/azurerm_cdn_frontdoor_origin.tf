resource "azurerm_cdn_frontdoor_origin" "example" {
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.example.id
  certificate_name_check_enabled = false
  host_name                      = "contoso.com"
  name                           = "example-origin"
  health_probes_enabled          = var.azurerm_cdn_frontdoor_origin_health_probes_enabled
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = "www.contoso.com"
  priority                       = 1
  weight                         = 1
}

locals {
  azurerm_cdn_frontdoor_origin_health_probes_enabled = azurerm_cdn_frontdoor_origin.example.health_probes_enabled
}