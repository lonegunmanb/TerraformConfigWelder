resource "azurerm_network_interface" "example" {
  location                       = azurerm_resource_group.example.location
  name                           = "example-nic"
  resource_group_name            = azurerm_resource_group.example.name
  accelerated_networking_enabled = var.azurerm_network_interface_enable_accelerated_networking
  dns_servers                    = var.azurerm_network_interface_dns_servers
  ip_forwarding_enabled          = var.azurerm_network_interface_enable_ip_forwarding

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.example.id
  }

  lifecycle {
    ignore_changes = [dns_servers]
  }
}

locals {
  azurerm_network_interface_enable_accelerated_networking = azurerm_network_interface.example.accelerated_networking_enabled
  azurerm_network_interface_enable_ip_forwarding          = azurerm_network_interface.example.ip_forwarding_enabled
}