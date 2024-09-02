resource "azurerm_storage_share_directory" "example" {
  name             = "example"
  storage_share_id = data.azurerm_storage_share.azurerm_storage_share_directory_example.id
}

resource "azurerm_storage_share_directory" "example_alternate_provider" {
  provider = azurerm.alternate

  name             = "example"
  storage_share_id = data.azurerm_storage_share.azurerm_storage_share_directory_example_alternate_provider.id
}

resource "azurerm_storage_share_directory" "example_alternate_provider_with_for_each" {
  provider = azurerm.alternate
  for_each = ["a", "b"]

  name             = "example"
  storage_share_id = data.azurerm_storage_share.azurerm_storage_share_directory_example_alternate_provider_with_for_each[each.key].id
}

locals {
  azure_storage_share_directory_for_each_share_name              = data.azurerm_storage_share.azurerm_storage_share_directory_example_alternate_provider_with_for_each["a"].name
  azure_storage_share_directory_for_each_storage_account_name    = data.azurerm_storage_share.azurerm_storage_share_directory_example_alternate_provider_with_for_each["a"].storage_account_name
  azurerm_storage_share_directory_share_name                     = data.azurerm_storage_share.azurerm_storage_share_directory_example.name
  azurerm_storage_share_directory_share_name_alternate           = data.azurerm_storage_share.azurerm_storage_share_directory_example_alternate_provider.name
  azurerm_storage_share_directory_storage_account_name           = data.azurerm_storage_share.azurerm_storage_share_directory_example.storage_account_name
  azurerm_storage_share_directory_storage_account_name_alternate = data.azurerm_storage_share.azurerm_storage_share_directory_example_alternate_provider.storage_account_name
}
data "azurerm_storage_share" "azurerm_storage_share_directory_example_alternate_provider" {
  provider = azurerm.alternate

  name                 = var.azurerm_storage_share_directory_share_name_alternate
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name_alternate
}

data "azurerm_storage_share" "azurerm_storage_share_directory_example" {
  provider = azurerm

  name                 = var.azurerm_storage_share_directory_share_name
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name
}

data "azurerm_storage_share" "azurerm_storage_share_directory_example_alternate_provider_with_for_each" {
  provider = azurerm.alternate
  for_each = ["a", "b"]

  name                 = var.azurerm_storage_share_directory_share_name_alternate
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name_alternate
}

