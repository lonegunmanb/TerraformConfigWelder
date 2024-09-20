resource "azurerm_cognitive_deployment" "static" {
  cognitive_account_id = azurerm_cognitive_account.example.id
  name                 = "example-cd"

  model {
    format  = "OpenAI"
    name    = "text-curie-001"
    version = "1"
  }
  dynamic "sku" {
    for_each = ["sku"]
    iterator = scale

    content {
      capacity = var.azurerm_cognitive_deployment_scale_capacity
      family   = var.azurerm_cognitive_deployment_scale_family
      name     = var.azurerm_cognitive_deployment_scale_type
      size     = var.azurerm_cognitive_deployment_scale_size
      tier     = var.azurerm_cognitive_deployment_scale_tier
    }
  }
}

locals {
  azurerm_cognitive_deployment_static_scale_capacity = azurerm_cognitive_deployment.static.sku[0].capacity
  azurerm_cognitive_deployment_static_scale_family   = azurerm_cognitive_deployment.static.sku[0].family
  azurerm_cognitive_deployment_static_scale_size     = azurerm_cognitive_deployment.static.sku[0].size
  azurerm_cognitive_deployment_static_scale_tier     = azurerm_cognitive_deployment.static.sku[0].tier
  azurerm_cognitive_deployment_static_scale_type     = azurerm_cognitive_deployment.static.sku[0].name
}

resource "azurerm_cognitive_deployment" "dynamic" {
  cognitive_account_id = azurerm_cognitive_account.example.id
  name                 = "example-cd"

  model {
    format  = "OpenAI"
    name    = "text-curie-001"
    version = "1"
  }
  dynamic "sku" {
    for_each = [var.azurerm_cognitive_deployment_scale]
    iterator = scale

    content {
      capacity = scale.value.capacity
      family   = scale.value.family
      name     = scale.value.type
      size     = scale.value.size
      tier     = scale.value.tier
    }
  }
}