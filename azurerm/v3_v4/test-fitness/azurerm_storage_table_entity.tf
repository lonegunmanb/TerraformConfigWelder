resource "azurerm_storage_table_entity" "singleton" {
  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_storage_account_name
  table_name           = var.azurerm_storage_table_entity_storage_table_name
}

resource "azurerm_storage_table_entity" "count" {
  count = var.azurerm_storage_table_entity_count

  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_count_storage_account_name
  table_name           = var.azurerm_storage_table_entity_count_storage_table_name
}

resource "azurerm_storage_table_entity" "for_each" {
  for_each = var.azurerm_storage_table_entity_for_each

  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_for_each_storage_account_name
  table_name           = var.azurerm_storage_table_entity_for_each_storage_table_name
}

resource "azurerm_storage_table_entity" "for_each_with_alternate_provider" {
  provider = azurerm.alternate
  for_each = var.azurerm_storage_table_entity_for_each

  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_for_each_with_alternate_storage_account_name
  table_name           = var.azurerm_storage_table_entity_for_each_with_alternate_storage_table_name
}

locals {
  azurerm_storage_table_entity_count_storage_name                                    = azurerm_storage_table_entity.count[0].storage_account_name
  azurerm_storage_table_entity_for_each_table_name                                   = azurerm_storage_table_entity.for_each["a"].table_name
  azurerm_storage_table_entity_for_each_with_alternate_provider_storage_account_name = azurerm_storage_table_entity.for_each_with_alternate_provider["a"].storage_account_name
  azurerm_storage_table_entity_for_each_with_alternate_provider_table_name           = azurerm_storage_table_entity.for_each_with_alternate_provider["a"].table_name
}