resource "azurerm_signalr_service" "example" {
  count = 1

  location                      = azurerm_resource_group.example.location
  name                          = "tfex-signalr"
  resource_group_name           = azurerm_resource_group.example.name
  connectivity_logs_enabled     = true
  live_trace_enabled            = var.azurerm_signalr_service_live_trace_enabled
  messaging_logs_enabled        = true
  public_network_access_enabled = false
  service_mode                  = "Default"

  sku {
    capacity = 1
    name     = "Free_F1"
  }
  cors {
    allowed_origins = ["http://www.example.com"]
  }
  upstream_endpoint {
    category_pattern = ["connections", "messages"]
    event_pattern    = ["*"]
    hub_pattern      = ["hub1"]
    url_template     = "http://foo.com"
  }
}

locals {
  azurerm_signalr_service_live_trace_enabled = azurerm_signalr_service.example[0].live_trace_enabled
}