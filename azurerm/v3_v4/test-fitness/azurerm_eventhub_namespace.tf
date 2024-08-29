resource "azurerm_eventhub_namespace" "example" {
  location            = azurerm_resource_group.example.location
  name                = "example-namespace"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  capacity            = 2
  tags = {
    environment = "Production"
  }
  zone_redundant = var.azurerm_eventhub_namespace_zone_redundant
}