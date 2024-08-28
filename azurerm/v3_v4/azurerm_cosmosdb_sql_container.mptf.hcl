locals {
  cosmosdb_sql_container_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_cosmosdb_sql_container"]) : [for b in blocks : b]])
  cosmosdb_sql_container_resource_blocks_map = { for block in local.cosmosdb_sql_container_resource_blocks : block.mptf.block_address => block }
  cosmosdb_sql_container_with_partition_key_path = {
    for key, block in local.cosmosdb_sql_container_resource_blocks_map : key => block if try(block.partition_key_path != null, false)
  }
}

transform "update_in_place" cosmosdb_sql_with_partition_key_path {
  for_each             = var.azurerm_cosmosdb_sql_container_toggle ? local.cosmosdb_sql_container_with_partition_key_path : tomap({})
  target_block_address = each.key
  asstring {
    partition_key_paths = "[${local.cosmosdb_sql_container_resource_blocks_map[each.key].partition_key_path}]"
  }
}

transform "remove_block_element" cosmosdb_sql_with_partition_key_path {
  for_each             = var.azurerm_cosmosdb_sql_container_toggle ? local.cosmosdb_sql_container_with_partition_key_path : tomap({})
  target_block_address = each.key
  paths                = ["partition_key_path"]
  depends_on = [
    transform.update_in_place.cosmosdb_sql_with_partition_key_path,
  ]
}

transform regex_replace_expression cosmosdb_sql_with_partition_key_path {
  for_each    = var.azurerm_cosmosdb_account_toggle ? ["cosmosdb_sql_with_partition_key_path"] : []
  regex       = "(^|[^d]$|[^a]d$|[^t]da$|[^a]dat$|[^.]data$)azurerm_cosmosdb_sql_container\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\n\\s*)?partition_key_path([^s]|$)"
  replacement = "azurerm_cosmosdb_sql_container.$${1}$${2}$${3}$${4}$${5}partition_key_paths[0]"
  depends_on = [
    transform.rename_block_element.simply_renamed,
  ]
}