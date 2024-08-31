resource "azurerm_servicebus_topic" "example" {
  count = 1

  name                       = "tfex_servicebus_topic"
  namespace_id               = azurerm_servicebus_namespace.example.id
  batched_operations_enabled = var.azurerm_servicebus_topic_enable_batched_operations
  express_enabled            = var.azurerm_servicebus_topic_enable_express
  partitioning_enabled       = var.azurerm_servicebus_topic_enable_partitioning

  lifecycle {
    ignore_changes = [batched_operations_enabled, express_enabled, partitioning_enabled]
  }
}

locals {
  azurerm_servicebus_topic_enable_batched_operations = azurerm_servicebus_topic.example[0].batched_operations_enabled
  azurerm_servicebus_topic_enable_express            = azurerm_servicebus_topic.example[0].express_enabled
  azurerm_servicebus_topic_enable_partitioning       = azurerm_servicebus_topic.example[0].partitioning_enabled
}