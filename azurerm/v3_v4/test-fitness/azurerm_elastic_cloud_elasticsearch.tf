resource "azurerm_elastic_cloud_elasticsearch" "test" {
  elastic_cloud_email_address = "user@example.com"
  location                    = azurerm_resource_group.test.location
  name                        = "example-elasticsearch"
  resource_group_name         = azurerm_resource_group.test.name
  sku_name                    = "ess-consumption-2024_Monthly"
}