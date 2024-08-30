resource "azurerm_network_interface" "example" {
  location                      = azurerm_resource_group.example.location
  name                          = "example-nic"
  resource_group_name           = azurerm_resource_group.example.name
  dns_servers                   = var.azurerm_network_interface_dns_servers
  enable_accelerated_networking = var.azurerm_network_interface_enable_accelerated_networking
  enable_ip_forwarding          = var.azurerm_network_interface_enable_ip_forwarding

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.example.id
  }
}

locals {
  azurerm_network_interface_enable_accelerated_networking = azurerm_network_interface.example.enable_accelerated_networking
  azurerm_network_interface_enable_ip_forwarding          = azurerm_network_interface.example.enable_ip_forwarding
}