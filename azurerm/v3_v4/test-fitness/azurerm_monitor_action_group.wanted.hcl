resource "azurerm_monitor_action_group" "example" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "p0action"

  event_hub_receiver {
    name                    = "sendtoeventhub"
    event_hub_name          = split("/", var.azurerm_monitor_action_group.event_hub_receiver_event_hub_id)[10]
    event_hub_namespace     = split("/", var.azurerm_monitor_action_group.event_hub_receiver_event_hub_id)[8]
    subscription_id         = "00000000-0000-0000-0000-000000000000"
    use_common_alert_schema = false
  }

  lifecycle {
    ignore_changes = [event_hub_receiver[0].event_hub_name, event_hub_receiver[0].event_hub_namespace]
  }
}