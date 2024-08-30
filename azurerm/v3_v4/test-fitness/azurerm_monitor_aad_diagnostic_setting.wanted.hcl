resource "azurerm_monitor_aad_diagnostic_setting" "example" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = ["enabled_log"]
    iterator = log

    content {
      category = "AuditLogs"

      dynamic "retention_policy" {
        for_each = ["retention_policy"]
        iterator = retention_policy

        content {
          days    = 1
          enabled = true
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [enabled_log]
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "example_with_enabled" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = (var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? ["enabled_log"] : []
    iterator = log

    content {
      category = "AuditLogs"

      dynamic "retention_policy" {
        for_each = ["retention_policy"]
        iterator = retention_policy

        content {
          days    = 1
          enabled = true
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [enabled_log]
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? { for k, v in(var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []) : k => v } : tomap({}), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []) : toset([]), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []))
    iterator = log

    content {
      category = "AuditLogs"

      dynamic "retention_policy" {
        for_each = ["retention_policy"]
        iterator = retention_policy

        content {
          days    = 1
          enabled = true
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [enabled_log]
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log_with_usage_of_iterator" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? { for k, v in(var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["AuditLogs"] : []) : k => v } : tomap({}), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["AuditLogs"] : []) : toset([]), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["AuditLogs"] : []))
    iterator = log

    content {
      category = log.value

      dynamic "retention_policy" {
        for_each = ["retention_policy"]
        iterator = retention_policy

        content {
          days    = 1
          enabled = true
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [enabled_log]
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log_with_iterator" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? { for k, v in(var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []) : k => v } : tomap({}), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []) : toset([]), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []))
    iterator = l

    content {
      category = "AuditLogs"

      dynamic "retention_policy" {
        for_each = ["retention_policy"]
        iterator = retention_policy

        content {
          days    = 1
          enabled = true
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [enabled_log]
  }
}

resource "azurerm_monitor_aad_diagnostic_setting" "dynamic_log_retention_policy" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? { for k, v in(var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []) : k => v } : tomap({}), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled) ? (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []) : toset([]), (var.azurerm_monitor_aad_diagnostic_setting_log_enabled ? ["log"] : []))
    iterator = log

    content {
      category = "AuditLogs"

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

  lifecycle {
    ignore_changes = [enabled_log]
  }
}

locals {
  azurerm_monitor_aad_diagnostic_setting_log = azurerm_monitor_aad_diagnostic_setting.example.enabled_log
}