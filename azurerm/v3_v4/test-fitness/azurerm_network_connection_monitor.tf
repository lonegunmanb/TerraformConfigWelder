resource "azurerm_network_connection_monitor" "example" {
  location                      = azurerm_network_watcher.example.location
  name                          = "example-Monitor"
  network_watcher_id            = azurerm_network_watcher.example.id
  notes                         = "examplenote"
  output_workspace_resource_ids = [azurerm_log_analytics_workspace.example.id]

  endpoint {
    name               = "source"
    target_resource_id = azurerm_virtual_machine.example.id

    filter {
      type = "Include"

      item {
        address = azurerm_virtual_machine.example.id
        type    = "AgentAddress"
      }
    }
  }
  endpoint {
    name    = "destination"
    address = "terraform.io"
  }
  test_configuration {
    name                      = "tcpName"
    protocol                  = "Tcp"
    test_frequency_in_seconds = 60

    tcp_configuration {
      port = 80
    }
  }
  test_group {
    destination_endpoints    = ["destination"]
    name                     = "exampletg"
    source_endpoints         = ["source"]
    test_configuration_names = ["tcpName"]
  }

  depends_on = [azurerm_virtual_machine_extension.example]
}