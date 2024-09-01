resource "azurerm_sentinel_data_connector_microsoft_threat_intelligence" "example" {
  log_analytics_workspace_id                   = azurerm_sentinel_log_analytics_workspace_onboarding.example.workspace_id
  name                                         = "example-dc-msti"
  microsoft_emerging_threat_feed_lookback_date = "1970-01-01T00:00:00Z"
}