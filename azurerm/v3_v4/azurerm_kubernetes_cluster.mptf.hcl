locals {
  kubernetes_cluster_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_kubernetes_cluster"]) : [for b in blocks : b]])
  kubernetes_cluster_resource_blocks_map = { for block in local.kubernetes_cluster_resource_blocks : block.mptf.block_address => block }
  kubernetes_cluster_with_web_app_routing_dns_zone_id = {
    for key, block in local.kubernetes_cluster_resource_blocks_map : key => block if can(block.web_app_routing[0].dns_zone_id) && !can(block.web_app_routing[0].dns_zone_ids)
  }
  kubernetes_cluster_with_api_server_authorized_ip_ranges = {
    for key, block in local.kubernetes_cluster_resource_blocks_map : key => block if can(block.api_server_authorized_ip_ranges) && !can(block.api_server_access_profile[0].authorized_ip_ranges)
  }

}

transform "update_in_place" kubernetes_cluster_with_web_app_routing_dns_zone_id {
  for_each             = var.azurerm_kubernetes_cluster_toggle ? local.kubernetes_cluster_with_web_app_routing_dns_zone_id : tomap({})
  target_block_address = each.key
  asstring {
    web_app_routing {
      dns_zone_ids = "[${each.value.web_app_routing[0].dns_zone_id}]"
    }
  }
}

transform "remove_block_element" kubernetes_cluster_with_web_app_routing_dns_zone_id {
  for_each             = var.azurerm_kubernetes_cluster_toggle ? local.kubernetes_cluster_with_web_app_routing_dns_zone_id : tomap({})
  target_block_address = each.key
  paths                = ["web_app_routing.dns_zone_id"]
  depends_on = [
    transform.update_in_place.kubernetes_cluster_with_web_app_routing_dns_zone_id,
  ]
}

transform regex_replace_expression kubernetes_cluster_with_web_app_routing_dns_zone_id {
  for_each    = var.azurerm_kubernetes_cluster_toggle ? ["kubernetes_cluster_with_web_app_routing_dns_zone_id"] : []
  regex       = "(^|[^d]$|[^a]d$|[^t]da$|[^a]dat$|[^.]data$)azurerm_kubernetes_cluster\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\n\\s*)?web_app_routing((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?dns_zone_id([^s]|$)"
  replacement = "azurerm_kubernetes_cluster.$${1}$${2}$${3}$${4}$${5}web_app_routing$${6}$${7}$${8}dns_zone_ids[0]"
  depends_on = [
    transform.remove_block_element.kubernetes_cluster_with_web_app_routing_dns_zone_id,
  ]
}

transform "update_in_place" kubernetes_cluster_with_api_server_authorized_ip_ranges {
  for_each             = var.azurerm_kubernetes_cluster_toggle ? local.kubernetes_cluster_with_api_server_authorized_ip_ranges : tomap({})
  target_block_address = each.key
  asstring {
    api_server_access_profile {
      authorized_ip_ranges = "${each.value.api_server_authorized_ip_ranges}"
    }
  }
}

transform "remove_block_element" kubernetes_cluster_with_api_server_authorized_ip_ranges {
  for_each             = var.azurerm_kubernetes_cluster_toggle ? local.kubernetes_cluster_with_api_server_authorized_ip_ranges : tomap({})
  target_block_address = each.key
  paths                = ["api_server_authorized_ip_ranges"]
  depends_on = [
    transform.update_in_place.kubernetes_cluster_with_api_server_authorized_ip_ranges,
  ]
}

transform regex_replace_expression kubernetes_cluster_with_api_server_authorized_ip_ranges {
  for_each    = var.azurerm_kubernetes_cluster_toggle ? ["kubernetes_cluster_with_web_app_routing_dns_zone_id"] : []
  regex       = "(^|[^d]$|[^a]d$|[^t]da$|[^a]dat$|[^.]data$)azurerm_kubernetes_cluster\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\n\\s*)?api_server_authorized_ip_ranges([^s]|$)"
  replacement = "azurerm_kubernetes_cluster.$${1}$${2}$${3}$${4}$${5}api_server_access_profile[0].authorized_ip_ranges"
  depends_on = [
    transform.remove_block_element.kubernetes_cluster_with_api_server_authorized_ip_ranges,
  ]
}