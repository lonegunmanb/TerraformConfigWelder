resource "azurerm_databricks_workspace" "example" {
  location                              = azurerm_resource_group.example.location
  name                                  = "databricks-test"
  resource_group_name                   = azurerm_resource_group.example.name
  sku                                   = "standard"
  network_security_group_rules_required = "AllRules"
  tags = {
    Environment = "Production"
  }
}