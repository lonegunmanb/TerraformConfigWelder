locals {
  data_cosmosdb_account_connection_strings_replacement = join(",", [for s in [
    "primary_sql_connection_string",
    "secondary_sql_connection_string",
    "primary_readonly_sql_connection_string",
    "secondary_readonly_sql_connection_string",
    "primary_mongodb_connection_string",
    "secondary_mongodb_connection_string",
    "primary_readonly_mongodb_connection_string",
    "secondary_readonly_mongodb_connection_string",
  ] : "try(data.azurerm_cosmosdb_account.$${1}$${2}$${3}$${4}$${5}${s}, \"\")"])
}

transform regex_replace_expression data_cosmosdb_account_connection_strings {
  for_each    = var.data_azurerm_cosmosdb_account_toggle ? ["cosmosdb_account_connection_strings"] : []
  regex       = "data.azurerm_cosmosdb_account\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?connection_strings"
  replacement = "compact([${local.data_cosmosdb_account_connection_strings_replacement}])"
  #  depends_on  = [transform.rename_block_element.data_simply_renamed]
}