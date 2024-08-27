resource "azurerm_automation_account" "example" {
  location            = azurerm_resource_group.example.location
  name                = "example-account"
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
  tags = {
    environment = "development"
  }

  encryption {
    key_vault_key_id = var.azurerm_automation_account_key_vault_key_id
    key_source       = var.azurerm_automation_account_key_source
  }
}