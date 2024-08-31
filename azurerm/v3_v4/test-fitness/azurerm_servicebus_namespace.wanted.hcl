resource "azurerm_servicebus_namespace" "example" {
  location            = azurerm_resource_group.example.location
  name                = "tfex-servicebus-namespace"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  tags = {
    source = "terraform"
  }
}