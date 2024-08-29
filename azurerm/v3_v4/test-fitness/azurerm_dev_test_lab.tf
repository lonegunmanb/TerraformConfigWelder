resource "azurerm_dev_test_lab" "example" {
  location            = azurerm_resource_group.example.location
  name                = "example-devtestlab"
  resource_group_name = azurerm_resource_group.example.name
  storage_type        = "Premium"
  tags = {
    "Sydney" = "Australia"
  }
}