resource "azurerm_mssql_managed_database" "example" {
  managed_instance_id = azurerm_mssql_managed_instance.example.id
  name                = "example"

  long_term_retention_policy {
    immutable_backups_enabled = var.azurerm_mssql_managed_database_long_term_retention_policy_immutable_backups_enabled
  }
}