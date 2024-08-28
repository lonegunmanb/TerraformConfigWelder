resource "azurerm_data_protection_backup_policy_blob_storage" "example" {
  name               = "example-backup-policy"
  vault_id           = azurerm_data_protection_backup_vault.example.id
  retention_duration = "P30D"
}

locals {
  azurerm_data_protection_backup_policy_blob_storage_retention_duration = azurerm_data_protection_backup_policy_blob_storage.example.retention_duration
}