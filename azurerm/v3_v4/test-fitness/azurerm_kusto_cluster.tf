resource "azurerm_kusto_cluster" "example" {
  location            = azurerm_resource_group.example.location
  name                = "kustocluster"
  resource_group_name = azurerm_resource_group.example.name
  engine              = var.azurerm_kusto_cluster_engine
  tags = {
    Environment = "Production"
  }

  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }
}