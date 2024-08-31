resource "azurerm_servicebus_topic" "example" {
  count = 1

  name                      = "tfex_servicebus_topic"
  namespace_id              = azurerm_servicebus_namespace.example.id
  enable_batched_operations = var.azurerm_servicebus_topic_enable_batched_operations
  enable_express            = var.azurerm_servicebus_topic_enable_express
  enable_partitioning       = var.azurerm_servicebus_topic_enable_partitioning
}

locals {
  azurerm_servicebus_topic_enable_batched_operations = azurerm_servicebus_topic.example[0].enable_batched_operations
  azurerm_servicebus_topic_enable_express            = azurerm_servicebus_topic.example[0].enable_express
  azurerm_servicebus_topic_enable_partitioning       = azurerm_servicebus_topic.example[0].enable_partitioning
}