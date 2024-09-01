resource "azurerm_signalr_service" "example" {
  count = 1

  location                      = azurerm_resource_group.example.location
  name                          = "tfex-signalr"
  resource_group_name           = azurerm_resource_group.example.name
  connectivity_logs_enabled     = true
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
  live_trace {
    enabled = var.azurerm_signalr_service_live_trace_enabled
  }
  upstream_endpoint {
    category_pattern = ["connections", "messages"]
    event_pattern    = ["*"]
    hub_pattern      = ["hub1"]
    url_template     = "http://foo.com"
  }

  lifecycle {
    ignore_changes = [cors]
  }
}

locals {
  azurerm_signalr_service_live_trace_enabled = (try(azurerm_managed_application.example[0].live_trace[0].enabled, false))
}