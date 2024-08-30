resource "azurerm_mssql_database" "example" {
  name         = "example-db"
  server_id    = azurerm_mssql_server.example.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  enclave_type = "VBS"
  license_type = "LicenseIncluded"
  max_size_gb  = 4
  read_scale   = true
  sku_name     = "S0"
  tags = {
    foo = "bar"
  }
  zone_redundant = true

  long_term_retention_policy {}

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}