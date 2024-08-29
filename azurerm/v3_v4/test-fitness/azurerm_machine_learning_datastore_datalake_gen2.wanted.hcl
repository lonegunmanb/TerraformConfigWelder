resource "azurerm_machine_learning_datastore_datalake_gen2" "example" {
  name                 = "example-datastore"
  storage_container_id = azurerm_storage_container.example.resource_manager_id
  workspace_id         = azurerm_machine_learning_workspace.example.id

  lifecycle {
    ignore_changes = [authority_url]
  }
}