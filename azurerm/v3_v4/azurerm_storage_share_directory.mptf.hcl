locals {
  storage_share_directory_resource_blocks = flatten([
    for _, blocks in flatten([
      for resource_type, resource_blocks in data.resource.all.result : resource_blocks
      if resource_type == "azurerm_storage_share_directory"
    ]) : [for b in blocks : b]
  ])
  storage_share_directory_resource_blocks_map = {
    for block in local.storage_share_directory_resource_blocks : block.mptf.block_address => block
  }
  storage_share_directory_with_storage_account_name_and_share_name = {
    for key, block in local.storage_share_directory_resource_blocks_map : key => block if can(block.storage_account_name) && can(block.share_name)
  }
  storage_share_directory_with_storage_account_name_and_share_name_and_count = {
    for key, block in local.storage_share_directory_with_storage_account_name_and_share_name : key => block if can(block.count)
  }
  storage_share_directory_with_storage_account_name_and_share_name_and_for_each = {
    for key, block in local.storage_share_directory_with_storage_account_name_and_share_name : key => block if can(block.for_each)
  }
  storage_share_directory_with_storage_account_name_and_share_name_singleton = {
    for key, block in local.storage_share_directory_with_storage_account_name_and_share_name : key => block if !can(block.for_each) && !can(block.count)
  }
}

transform "new_block" storage_share_directory_with_storage_account_name_and_share_name_singleton_data_source {
  for_each       = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_singleton : tomap({})
  new_block_type = "data"
  filename       = each.value.mptf.range.file_name
  labels         = ["azurerm_storage_share", "azurerm_storage_share_directory_${each.value.mptf.block_labels[1]}"]
  asstring {
    name                 = each.value.share_name
    storage_account_name = each.value.storage_account_name
    provider             = try(each.value.provider, "azurerm")
  }
}

transform "update_in_place" storage_share_directory_with_storage_account_name_and_share_name_singleton {
  for_each             = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_singleton : tomap({})
  target_block_address = each.key
  asstring {
    storage_share_id = "data.azurerm_storage_share.azurerm_storage_share_directory_${each.value.mptf.block_labels[1]}.id"
  }
  depends_on = [
    transform.new_block.storage_share_directory_with_storage_account_name_and_share_name_singleton_data_source,
  ]
}

transform "remove_block_element" storage_share_directory_with_storage_account_name_and_share_name_singleton {
  for_each             = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_singleton : tomap({})
  target_block_address = each.key
  paths                = ["share_name", "storage_account_name"]
  depends_on = [
    transform.update_in_place.storage_share_directory_with_storage_account_name_and_share_name_singleton,
  ]
}

transform "new_block" storage_share_directory_with_storage_account_name_and_share_name_count_data_source {
  for_each       = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_and_count : tomap({})
  new_block_type = "data"
  filename       = each.value.mptf.range.file_name
  labels         = ["azurerm_storage_share", "azurerm_storage_share_directory_${each.value.mptf.block_labels[1]}"]
  asstring {
    count                = each.value.count
    name                 = each.value.share_name
    storage_account_name = each.value.storage_account_name
    provider             = try(each.value.provider, "azurerm")
  }
  depends_on = [transform.remove_block_element.storage_share_directory_with_storage_account_name_and_share_name_singleton]
}

transform "update_in_place" storage_share_directory_with_storage_account_name_and_share_name_count {
  for_each             = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_and_count : tomap({})
  target_block_address = each.key
  asstring {
    storage_share_id = "data.azurerm_storage_share.azurerm_storage_share_directory_${each.value.mptf.block_labels[1]}[count.index].id"
  }
  depends_on = [
    transform.new_block.storage_share_directory_with_storage_account_name_and_share_name_count_data_source,
  ]
}

transform "remove_block_element" storage_share_directory_with_storage_account_name_and_share_name_count {
  for_each             = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_and_count : tomap({})
  target_block_address = each.key
  paths                = ["share_name", "storage_account_name"]
  depends_on = [
    transform.update_in_place.storage_share_directory_with_storage_account_name_and_share_name_count,
  ]
}

transform "new_block" storage_share_directory_with_storage_account_name_and_share_name_for_each {
  for_each       = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_and_for_each : tomap({})
  new_block_type = "data"
  filename       = each.value.mptf.range.file_name
  labels         = ["azurerm_storage_share", "azurerm_storage_share_directory_${each.value.mptf.block_labels[1]}"]
  asstring {
    for_each             = each.value.for_each
    name                 = each.value.share_name
    storage_account_name = each.value.storage_account_name
    provider             = try(each.value.provider, "azurerm")
  }
  depends_on = [transform.remove_block_element.storage_share_directory_with_storage_account_name_and_share_name_count]
}

transform "update_in_place" storage_share_directory_with_storage_account_name_and_share_name_for_each {
  for_each             = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_and_for_each : tomap({})
  target_block_address = each.key
  asstring {
    storage_share_id = "data.azurerm_storage_share.azurerm_storage_share_directory_${each.value.mptf.block_labels[1]}[each.key].id"
  }
  depends_on = [
    transform.new_block.storage_share_directory_with_storage_account_name_and_share_name_for_each,
  ]
}

transform "remove_block_element" storage_share_directory_with_storage_account_name_and_share_name_for_each {
  for_each             = var.azurerm_storage_share_directory_toggle ? local.storage_share_directory_with_storage_account_name_and_share_name_and_for_each : tomap({})
  target_block_address = each.key
  paths                = ["share_name", "storage_account_name"]
  depends_on = [
    transform.update_in_place.storage_share_directory_with_storage_account_name_and_share_name_for_each,
  ]
}

transform "regex_replace_expression" storage_share_directory_with_storage_account_name_and_share_name {
  for_each = var.azurerm_storage_share_directory_toggle ? tomap({
    "share_name" : "name",
    "storage_account_name" : "storage_account_name",
  }) : tomap({})
  regex       = "azurerm_storage_share_directory\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${each.key}"
  replacement = "data.azurerm_storage_share.azurerm_storage_share_directory_$${1}$${2}$${3}$${4}$${5}${each.value}"
}