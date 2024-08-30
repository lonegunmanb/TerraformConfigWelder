resource "azurerm_recovery_services_vault_resource_guard_association" "test" {
  resource_guard_id = azurerm_data_protection_resource_guard.test.id
  vault_id          = azurerm_recovery_services_vault.test.id
}