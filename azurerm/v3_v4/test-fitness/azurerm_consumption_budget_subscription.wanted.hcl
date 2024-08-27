resource "azurerm_consumption_budget_subscription" "example" {
  amount          = 1000
  name            = "example"
  subscription_id = data.azurerm_subscription.current.id
  time_grain      = "Monthly"

  notification {
    operator  = "EqualTo"
    threshold = 90.0
    contact_emails = [
      "foo@example.com",
      "bar@example.com",
    ]
    contact_groups = [
      azurerm_monitor_action_group.example.id,
    ]
    contact_roles = [
      "Owner",
    ]
    enabled = true
  }
  notification {
    operator  = "GreaterThan"
    threshold = 100.0
    contact_emails = [
      "foo@example.com",
      "bar@example.com",
    ]
    enabled        = false
    threshold_type = "Forecasted"
  }
  time_period {
    start_date = "2022-06-01T00:00:00Z"
    end_date   = "2022-07-01T00:00:00Z"
  }
  filter {
    dimension {
      name = "ResourceGroupName"
      values = [
        azurerm_resource_group.example.name,
      ]
    }
    tag {
      name = "foo"
      values = [
        "bar",
        "baz",
      ]
    }
  }
}