resource "azurerm_machine_learning_workspace" "example" {
  count = 1

  application_insights_id                      = azurerm_application_insights.example.id
  key_vault_id                                 = azurerm_key_vault.example.id
  location                                     = azurerm_resource_group.example.location
  name                                         = "example-workspace"
  resource_group_name                          = azurerm_resource_group.example.name
  storage_account_id                           = azurerm_storage_account.example.id
  public_access_behind_virtual_network_enabled = var.azurerm_machine_learning_workspace_public_access_behind_virtual_network_enabled

  identity {
    type = "SystemAssigned"
  }
}

locals {
  azurerm_machine_learning_workspace_public_access_behind_virtual_network_enabled = azurerm_machine_learning_workspace.example[0].public_access_behind_virtual_network_enabled
}