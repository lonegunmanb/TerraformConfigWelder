resource "azurerm_mssql_managed_database" "example" {
  managed_instance_id = azurerm_mssql_managed_instance.example.id
  name                = "example"

  long_term_retention_policy {}
}