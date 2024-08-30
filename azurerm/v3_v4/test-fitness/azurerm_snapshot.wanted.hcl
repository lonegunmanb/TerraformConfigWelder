resource "azurerm_snapshot" "empty_encryption_settings" {
  create_option       = "Copy"
  location            = azurerm_resource_group.example.location
  name                = "snapshot"
  resource_group_name = azurerm_resource_group.example.name
  source_uri          = azurerm_managed_disk.example.id

  encryption_settings {}
}

resource "azurerm_snapshot" "encryption_settings_with_enabled" {
  create_option       = "Copy"
  location            = azurerm_resource_group.example.location
  name                = "snapshot"
  resource_group_name = azurerm_resource_group.example.name
  source_uri          = azurerm_managed_disk.example.id

  dynamic "encryption_settings" {
    for_each = (var.azure_snapshot_encryption_enabled) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}

resource "azurerm_snapshot" "dynamic_empty_encryption_settings" {
  create_option       = "Copy"
  location            = azurerm_resource_group.example.location
  name                = "snapshot"
  resource_group_name = azurerm_resource_group.example.name
  source_uri          = azurerm_managed_disk.example.id

  dynamic "encryption_settings" {
    for_each = var.azure_snapshot_encryption_enabled ? ["encryption_settings"] : []

    content {}
  }
}

resource "azurerm_snapshot" "dynamic_encryption_settings_with_set_for_each" {
  create_option       = "Copy"
  location            = azurerm_resource_group.example.location
  name                = "snapshot"
  resource_group_name = azurerm_resource_group.example.name
  source_uri          = azurerm_managed_disk.example.id

  dynamic "encryption_settings" {
    for_each = try((var.azure_snapshot_encryption_enabled) ? { for k, v in(toset([{
      disk_encryption_key = var.azure_snapshot_encryption_settings_disk_encryption_key
      key_encryption_key  = var.azure_snapshot_encryption_settings_key_encryption_key
      }])) : k => v } : tomap({}), (var.azure_snapshot_encryption_enabled) ? (toset([{
      disk_encryption_key = var.azure_snapshot_encryption_settings_disk_encryption_key
      key_encryption_key  = var.azure_snapshot_encryption_settings_key_encryption_key
    }])) : toset([]))
    iterator = enc

    content {
      dynamic "disk_encryption_key" {
        for_each = ["disk_encryption_key"]
        iterator = disk_encryption_key

        content {
          secret_url      = enc.key.disk_encryption_key.secret_url
          source_vault_id = enc.key.disk_encryption_key.source_vault_id
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = enc.key.key_encryption_key.key_url
          source_vault_id = enc.key.key_encryption_key.source_vault_id
        }
      }
    }
  }
}

resource "azurerm_snapshot" "dynamic_encryption_settings_with_map_for_each" {
  create_option       = "Copy"
  location            = azurerm_resource_group.example.location
  name                = "snapshot"
  resource_group_name = azurerm_resource_group.example.name
  source_uri          = azurerm_managed_disk.example.id

  dynamic "encryption_settings" {
    for_each = try((var.azure_snapshot_encryption_enabled) ? { for k, v in({
      snapshot = {
        disk_encryption_key = var.azure_snapshot_encryption_settings_disk_encryption_key
        key_encryption_key  = var.azure_snapshot_encryption_settings_key_encryption_key
      }
      }) : k => v } : tomap({}), (var.azure_snapshot_encryption_enabled) ? ({
      snapshot = {
        disk_encryption_key = var.azure_snapshot_encryption_settings_disk_encryption_key
        key_encryption_key  = var.azure_snapshot_encryption_settings_key_encryption_key
      }
    }) : toset([]))
    iterator = enc

    content {
      dynamic "disk_encryption_key" {
        for_each = ["disk_encryption_key"]
        iterator = disk_encryption_key

        content {
          secret_url      = enc.value.disk_encryption_key.secret_url
          source_vault_id = enc.value.disk_encryption_key.source_vault_id
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = enc.value.key_encryption_key.key_url
          source_vault_id = enc.value.key_encryption_key.source_vault_id
        }
      }
    }
  }
}