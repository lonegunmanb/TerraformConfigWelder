resource "azurerm_sentinel_alert_rule_scheduled" "example" {
  display_name               = "example"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.example.workspace_id
  name                       = "example"
  query                      = <<QUERY
AzureActivity |
  where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
  where ActivityStatus == "Succeeded" |
  make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
QUERY
  severity                   = "High"

  incident {
    create_incident_enabled = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_create_incident
    by_alert_details        = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_alert_details
    by_custom_details       = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_custom_details
    by_entities             = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_entities
  }
}

locals {
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_create_incident         = azurerm_sentinel_alert_rule_scheduled.example.incident[0].create_incident_enabled
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_alert_details  = azurerm_sentinel_alert_rule_scheduled.example.incident[0].by_alert_details
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_custom_details = azurerm_sentinel_alert_rule_scheduled.example.incident[0].by_custom_details
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_entities       = azurerm_sentinel_alert_rule_scheduled.example.incident[0].by_entities
}