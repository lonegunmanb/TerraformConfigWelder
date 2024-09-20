resource "azurerm_cognitive_deployment" "static" {
  name                 = "example-cd"
  cognitive_account_id = azurerm_cognitive_account.example.id
  model {
    format  = "OpenAI"
    name    = "text-curie-001"
    version = "1"
  }

  scale {
    type     = var.azurerm_cognitive_deployment_scale_type
    tier     = var.azurerm_cognitive_deployment_scale_tier
    size     = var.azurerm_cognitive_deployment_scale_size
    family   = var.azurerm_cognitive_deployment_scale_family
    capacity = var.azurerm_cognitive_deployment_scale_capacity
  }
}

locals {
  azurerm_cognitive_deployment_static_scale_type     = azurerm_cognitive_deployment.static.scale[0].type
  azurerm_cognitive_deployment_static_scale_tier     = azurerm_cognitive_deployment.static.scale[0].tier
  azurerm_cognitive_deployment_static_scale_size     = azurerm_cognitive_deployment.static.scale[0].size
  azurerm_cognitive_deployment_static_scale_family   = azurerm_cognitive_deployment.static.scale[0].family
  azurerm_cognitive_deployment_static_scale_capacity = azurerm_cognitive_deployment.static.scale[0].capacity
}

resource "azurerm_cognitive_deployment" "dynamic" {
  name                 = "example-cd"
  cognitive_account_id = azurerm_cognitive_account.example.id
  model {
    format  = "OpenAI"
    name    = "text-curie-001"
    version = "1"
  }

  dynamic "scale" {
    for_each = [var.azurerm_cognitive_deployment_scale]
    content {
      type     = scale.value.type
      tier     = scale.value.tier
      size     = scale.value.size
      family   = scale.value.family
      capacity = scale.value.capacity
    }
  }
}