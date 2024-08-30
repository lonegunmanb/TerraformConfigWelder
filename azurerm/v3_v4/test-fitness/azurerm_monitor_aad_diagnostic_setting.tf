resource "azurerm_monitor_aad_diagnostic_setting" "example" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  log {
    category = "AuditLogs"

    retention_policy {
      days    = 1
      enabled = true
    }
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "example_with_enabled" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  log {
    category = "AuditLogs"
    enabled  = var.azurerm_monitor_aad_diagnostic_setting_log_enabled

    retention_policy {
      days    = 1
      enabled = true
    }
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []

    content {
      category = "AuditLogs"
      enabled  = var.azurerm_monitor_aad_diagnostic_setting_log_enabled

      retention_policy {
        days    = 1
        enabled = true
      }
    }
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log_with_usage_of_iterator" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["AuditLogs"] : []

    content {
      category = log.value
      enabled  = var.azurerm_monitor_aad_diagnostic_setting_log_enabled

      retention_policy {
        days    = 1
        enabled = true
      }
    }
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log_with_iterator" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []
    iterator = l

    content {
      category = "AuditLogs"
      enabled  = var.azurerm_monitor_aad_diagnostic_setting_log_enabled

      retention_policy {
        days    = 1
        enabled = true
      }
    }
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log_retention_policy" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []

    content {
      category = "AuditLogs"
      enabled  = var.azurerm_monitor_aad_diagnostic_setting_log_enabled

      dynamic "retention_policy" {
        for_each = range(1, 7)
        iterator = retpol

        content {
          days    = retpol.value
          enabled = true
        }
      }
    }
  }
}

locals {
  azurerm_monitor_aad_diagnostic_setting_log = azurerm_monitor_aad_diagnostic_setting.example.log
}