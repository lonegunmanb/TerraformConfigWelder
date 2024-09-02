resource "azurerm_storage_table_entity" "singleton" {
  entity = {
    example = "example"
  }
  partition_key    = "examplepartition"
  row_key          = "examplerow"
  storage_table_id = data.azurerm_storage_table.azurerm_storage_table_entity_singleton.id
}

resource "azurerm_storage_table_entity" "count" {
  count = var.azurerm_storage_table_entity_count

  entity = {
    example = "example"
  }
  partition_key    = "examplepartition"
  row_key          = "examplerow"
  storage_table_id = data.azurerm_storage_table.azurerm_storage_table_entity_count[count.index].id
}

resource "azurerm_storage_table_entity" "for_each" {
  for_each = var.azurerm_storage_table_entity_for_each

  entity = {
    example = "example"
  }
  partition_key    = "examplepartition"
  row_key          = "examplerow"
  storage_table_id = data.azurerm_storage_table.azurerm_storage_table_entity_for_each[each.key].id
}

resource "azurerm_storage_table_entity" "for_each_with_alternate_provider" {
  provider = azurerm.alternate
  for_each = var.azurerm_storage_table_entity_for_each

  entity = {
    example = "example"
  }
  partition_key    = "examplepartition"
  row_key          = "examplerow"
  storage_table_id = data.azurerm_storage_table.azurerm_storage_table_entity_for_each_with_alternate_provider[each.key].id
}

locals {
  azurerm_storage_table_entity_count_storage_name                                    = data.azurerm_storage_table.azurerm_storage_table_entity_count[0].storage_account_name
  azurerm_storage_table_entity_for_each_table_name                                   = data.azurerm_storage_table.azurerm_storage_table_entity_for_each["a"].name
  azurerm_storage_table_entity_for_each_with_alternate_provider_storage_account_name = data.azurerm_storage_table.azurerm_storage_table_entity_for_each_with_alternate_provider["a"].storage_account_name
  azurerm_storage_table_entity_for_each_with_alternate_provider_table_name           = data.azurerm_storage_table.azurerm_storage_table_entity_for_each_with_alternate_provider["a"].name
}
data "azurerm_storage_table" "azurerm_storage_table_entity_singleton" {
  provider = azurerm

  name                 = var.azurerm_storage_table_entity_storage_table_name
  storage_account_name = var.azurerm_storage_table_entity_storage_account_name
}

data "azurerm_storage_table" "azurerm_storage_table_entity_count" {
  provider = azurerm
  count    = var.azurerm_storage_table_entity_count

  name                 = var.azurerm_storage_table_entity_count_storage_table_name
  storage_account_name = var.azurerm_storage_table_entity_count_storage_account_name
}

data "azurerm_storage_table" "azurerm_storage_table_entity_for_each" {
  provider = azurerm
  for_each = var.azurerm_storage_table_entity_for_each

  name                 = var.azurerm_storage_table_entity_for_each_storage_table_name
  storage_account_name = var.azurerm_storage_table_entity_for_each_storage_account_name
}

data "azurerm_storage_table" "azurerm_storage_table_entity_for_each_with_alternate_provider" {
  provider = azurerm.alternate
  for_each = var.azurerm_storage_table_entity_for_each

  name                 = var.azurerm_storage_table_entity_for_each_with_alternate_storage_table_name
  storage_account_name = var.azurerm_storage_table_entity_for_each_with_alternate_storage_account_name
}

