resource "azurerm_servicebus_queue" "example" {
  name                       = "tfex_servicebus_queue"
  namespace_id               = azurerm_servicebus_namespace.example.id
  batched_operations_enabled = var.azurerm_servicebus_queue_enable_batched_operations
  express_enabled            = var.azurerm_servicebus_queue_enable_express
  partitioning_enabled       = var.azurerm_servicebus_queue_enable_partitioning
}

locals {
  azurerm_servicebus_queue_enable_batched_operations = azurerm_servicebus_queue.example.batched_operations_enabled
  azurerm_servicebus_queue_enable_express            = azurerm_servicebus_queue.example.express_enabled
  azurerm_servicebus_queue_enable_partitioning       = azurerm_servicebus_queue.example.partitioning_enabled
}