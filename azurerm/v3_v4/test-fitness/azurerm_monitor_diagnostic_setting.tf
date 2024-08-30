resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  log {
    category       = "AuditEvent"
    category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_with_log_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  log {
    category       = "AuditEvent"
    category_group = var.azurerm_monitor_diagnostic_setting_log_category_group

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_log_with_enabled" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  log {
    category       = "AuditEvent"
    category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    enabled        = var.azurerm_monitor_diagnostic_setting_log_enabled
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_enabled" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = ["AuditEvent", "SecurityEvent"]

    content {
      category       = log.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
      enabled        = var.azurerm_monitor_diagnostic_setting_log_enabled
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_enabled_and_iterator" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = ["AuditEvent", "SecurityEvent"]
    iterator = l

    content {
      category       = l.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
      enabled        = var.azurerm_monitor_diagnostic_setting_log_enabled
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_static_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = ["AuditEvent", "SecurityEvent"]

    content {
      category       = log.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
      enabled        = var.azurerm_monitor_diagnostic_setting_log_enabled

      retention_policy {
        enabled = true
        days    = 1
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_dynamic_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "log" {
    for_each = ["AuditEvent", "SecurityEvent"]

    content {
      category       = log.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
      enabled        = var.azurerm_monitor_diagnostic_setting_log_enabled

      dynamic "retention_policy" {
        for_each = range(1, 8)
        iterator = retpol

        content {
          enabled = true
          days    = retpol.value
        }
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "enabled_log_with_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  enabled_log {
    category = "Audit"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "metric_with_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  metric {
    category = "Audit"

    retention_policy {
      enabled = false
    }
  }
}