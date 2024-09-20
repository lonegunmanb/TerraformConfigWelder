locals {
  cognitive_deployment_resource_blocks = flatten([
    for _, blocks in flatten([
      for resource_type, resource_blocks in data.resource.all.result : resource_blocks
      if resource_type == "azurerm_cognitive_deployment"
    ]) : [for b in blocks : b]
  ])
  cognitive_deployment_resource_blocks_map = {
    for block in local.cognitive_deployment_resource_blocks : block.mptf.block_address => block
  }
  cognitive_deployment_with_scale = {
    for key, block in local.cognitive_deployment_resource_blocks_map : key => block if can(block.scale[0])
  }
}

transform "remove_block_element" cognitive_deployment_scale {
  for_each = var.azurerm_cognitive_deployment_toggle ? local.cognitive_deployment_with_scale : {}

  target_block_address = each.key
  paths                = ["scale"]
}

transform "update_in_place" cognitive_deployment_sku {
  for_each = var.azurerm_cognitive_deployment_toggle ? local.cognitive_deployment_with_scale : {}

  target_block_address = each.key
  asstring {
    dynamic "sku" {
      for_each = try(each.value.scale[0].for_each, "[\"sku\"]")
      iterator = try(each.value.scale[0].iterator, "scale")
      content {
        name     = each.value.scale[0].type
        tier     = try(each.value.scale[0].tier, "null")
        size     = try(each.value.scale[0].size, "null")
        family   = try(each.value.scale[0].family, "null")
        capacity = try(each.value.scale[0].capacity, "null")
      }
    }
  }
  depends_on = [transform.remove_block_element.cognitive_deployment_scale]
}

transform "regex_replace_expression" cognitive_deployment_sku_name {
  for_each    = var.azurerm_cognitive_deployment_toggle ? ["azurerm_cognitive_deployment"] : []
  regex       = "azurerm_cognitive_deployment\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?scale((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?type"
  replacement = "azurerm_cognitive_deployment.$${1}$${2}$${3}$${4}$${5}sku$${6}$${7}$${8}name"
  depends_on = [transform.update_in_place.cognitive_deployment_sku]
}

transform "regex_replace_expression" cognitive_deployment_sku {
  for_each    = var.azurerm_cognitive_deployment_toggle ? ["azurerm_cognitive_deployment"] : []
  regex       = "azurerm_cognitive_deployment\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?scale"
  replacement = "azurerm_cognitive_deployment.$${1}$${2}$${3}$${4}$${5}sku"
  depends_on = [transform.regex_replace_expression.cognitive_deployment_sku_name]
}