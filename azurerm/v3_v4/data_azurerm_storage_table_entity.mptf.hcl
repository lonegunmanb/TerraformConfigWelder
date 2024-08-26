transform regex_replace_expression data_azurerm_storage_table_entity_storage_account_name {
  for_each = var.data_azurerm_storage_share_directory_toggle ? [
    "data_azurerm_storage_table_entity_storage_account_name",
  ] : []
  regex       = "data.azurerm_storage_table_entity\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?storage_account_name"
  replacement = "regex(\"https://(?P<accountname>[^.]+)\", data.azurerm_storage_table_entity.$${1}$${2}$${3}$${4}$${5}storage_table_id)[\"accountname\"]"
}

transform regex_replace_expression data_azurerm_storage_table_entity_table_name {
  for_each = var.data_azurerm_storage_share_directory_toggle ? [
    "data_azurerm_storage_table_entity_table_name",
  ] : []
  regex       = "data.azurerm_storage_table_entity\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?table_name"
  replacement = "regex(\"https://[^/]+/(?P<tablename>[^\\\\(]+)\", data.azurerm_storage_table_entity.$${1}$${2}$${3}$${4}$${5}storage_table_id)[\"tablename\"]"
}