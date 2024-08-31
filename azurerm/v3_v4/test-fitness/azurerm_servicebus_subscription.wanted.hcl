resource "azurerm_servicebus_subscription" "example" {
  max_delivery_count         = 1
  name                       = "tfex_servicebus_subscription"
  topic_id                   = azurerm_servicebus_topic.example.id
  batched_operations_enabled = var.azurerm_servicebus_subscription_enable_batched_operations
}

locals {
  azurem_servicebus_subscription_enable_batched_operations = azurerm_servicebus_subscription.example.batched_operations_enabled
}