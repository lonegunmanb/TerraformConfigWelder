resource "azurerm_consumption_budget_management_group" "example" {
  amount              = 1000
  management_group_id = azurerm_management_group.example.id
  name                = "example"
  time_grain          = "Monthly"

  notification {
    contact_emails = [
      "foo@example.com",
      "bar@example.com",
    ]
    operator  = "EqualTo"
    threshold = 90.0
    enabled   = true
  }
  notification {
    contact_emails = [
      "foo@example.com",
      "bar@example.com",
    ]
    operator       = "GreaterThan"
    threshold      = 100.0
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
    not {}
    tag {
      name = "foo"
      values = [
        "bar",
        "baz",
      ]
    }
  }
}