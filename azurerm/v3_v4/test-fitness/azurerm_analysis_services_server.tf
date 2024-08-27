resource "azurerm_analysis_services_server" "server" {
  location                = azurerm_resource_group.example.location
  name                    = "analysisservicesserver"
  resource_group_name     = azurerm_resource_group.example.name
  sku                     = "S0"
  admin_users             = ["myuser@domain.tld"]
  enable_power_bi_service = true
  tags = {
    abc = 123
  }

  ipv4_firewall_rule {
    name        = "myRule1"
    range_end   = "210.117.252.255"
    range_start = "210.117.252.0"
  }
}

locals {
  azurerm_analysis_services_server_enable_power_bi_service = azurerm_analysis_services_server.server.enable_power_bi_service
}