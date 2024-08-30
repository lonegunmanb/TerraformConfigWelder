resource "azurerm_redis_cache" "example" {
  capacity            = 2
  family              = "C"
  location            = azurerm_resource_group.example.location
  name                = "example-cache"
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
    enable_authentication = var.azurerm_redis_cache_redis_configuration_enable_authentication
  }
}

locals {
  azurerm_redis_cache_enable_non_ssl_port                       = azurerm_redis_cache.example.enable_non_ssl_port
  azurerm_redis_cache_redis_configuration_enable_authentication = azurerm_redis_cache.example.redis_configuration[0].enable_authentication
}