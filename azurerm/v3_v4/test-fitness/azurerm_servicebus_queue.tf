resource "azurerm_servicebus_queue" "example" {
  name                      = "tfex_servicebus_queue"
  namespace_id              = azurerm_servicebus_namespace.example.id
  enable_batched_operations = var.azurerm_servicebus_queue_enable_batched_operations
  enable_express            = var.azurerm_servicebus_queue_enable_express
  enable_partitioning       = var.azurerm_servicebus_queue_enable_partitioning
  partitioning_enabled      = true
}

locals {
  azurerm_servicebus_queue_enable_batched_operations = azurerm_servicebus_queue.example.enable_batched_operations
  azurerm_servicebus_queue_enable_express            = azurerm_servicebus_queue.example.enable_express
  azurerm_servicebus_queue_enable_partitioning       = azurerm_servicebus_queue.example.enable_partitioning
}