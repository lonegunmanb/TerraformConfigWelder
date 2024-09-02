data "azurerm_monitor_diagnostic_categories" "example" {
  resource_id = data.azurerm_key_vault.example.id
}

locals {
  data_azurerm_monitor_diagnostic_logs = data.azurerm_monitor_diagnostic_categories.example.log_category_types
}