resource "azurerm_sentinel_alert_rule_ms_security_incident" "example" {
  display_name               = "example rule"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.example.workspace_id
  name                       = "example-ms-security-incident-alert-rule"
  product_filter             = "Microsoft Cloud App Security"
  severity_filter            = ["High"]

  lifecycle {
    ignore_changes = [display_name_filter]
  }
}