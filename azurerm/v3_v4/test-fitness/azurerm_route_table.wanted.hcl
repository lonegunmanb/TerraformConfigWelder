resource "azurerm_route_table" "example" {
  location                      = azurerm_resource_group.example.location
  name                          = "example-route-table"
  resource_group_name           = azurerm_resource_group.example.name
  bgp_route_propagation_enabled = !(var.azurerm_route_table_disable_bgp_route_propagation)
  tags = {
    environment = "Production"
  }

  route {
    address_prefix = "10.1.0.0/16"
    name           = "route1"
    next_hop_type  = "VnetLocal"
  }
}

locals {
  azurerm_route_table_disable_bgp_route_propagation = (!(azurerm_route_table.example.bgp_route_propagation_enabled))
}