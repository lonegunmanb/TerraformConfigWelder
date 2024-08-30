resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = ["enabled_log"]
    iterator = log

    content {
      category       = "AuditEvent"
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_with_log_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = ["enabled_log"]
    iterator = log

    content {
      category       = "AuditEvent"
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_log_with_enabled" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = (var.azurerm_monitor_diagnostic_setting_log_enabled) ? ["enabled_log"] : []
    iterator = log

    content {
      category       = "AuditEvent"
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_enabled" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_diagnostic_setting_log_enabled) ? { for k, v in(["AuditEvent", "SecurityEvent"]) : k => v } : tomap({}), (var.azurerm_monitor_diagnostic_setting_log_enabled) ? (["AuditEvent", "SecurityEvent"]) : toset([]), (["AuditEvent", "SecurityEvent"]))
    iterator = log

    content {
      category       = log.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_enabled_and_iterator" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_diagnostic_setting_log_enabled) ? { for k, v in(["AuditEvent", "SecurityEvent"]) : k => v } : tomap({}), (var.azurerm_monitor_diagnostic_setting_log_enabled) ? (["AuditEvent", "SecurityEvent"]) : toset([]), (["AuditEvent", "SecurityEvent"]))
    iterator = l

    content {
      category       = l.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_static_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_diagnostic_setting_log_enabled) ? { for k, v in(["AuditEvent", "SecurityEvent"]) : k => v } : tomap({}), (var.azurerm_monitor_diagnostic_setting_log_enabled) ? (["AuditEvent", "SecurityEvent"]) : toset([]), (["AuditEvent", "SecurityEvent"]))
    iterator = log

    content {
      category       = log.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example_dynamic_log_with_dynamic_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  dynamic "enabled_log" {
    for_each = try((var.azurerm_monitor_diagnostic_setting_log_enabled) ? { for k, v in(["AuditEvent", "SecurityEvent"]) : k => v } : tomap({}), (var.azurerm_monitor_diagnostic_setting_log_enabled) ? (["AuditEvent", "SecurityEvent"]) : toset([]), (["AuditEvent", "SecurityEvent"]))
    iterator = log

    content {
      category       = log.value
      category_group = var.azurerm_monitor_diagnostic_setting_log_category_group
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "enabled_log_with_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  enabled_log {
    category = "Audit"
  }
}

resource "azurerm_monitor_diagnostic_setting" "metric_with_retention_policy" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  metric {
    category = "Audit"
  }
}