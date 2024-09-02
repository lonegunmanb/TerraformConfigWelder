resource "azurerm_storage_share_directory" "example" {
  name                 = "example"
  share_name           = var.azurerm_storage_share_directory_share_name
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name
}

resource "azurerm_storage_share_directory" "example_alternate_provider" {
  provider = azurerm.alternate

  name                 = "example"
  share_name           = var.azurerm_storage_share_directory_share_name_alternate
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name_alternate
}

resource "azurerm_storage_share_directory" "example_alternate_provider_with_for_each" {
  provider = azurerm.alternate
  for_each = ["a", "b"]

  name                 = "example"
  share_name           = var.azurerm_storage_share_directory_share_name_alternate
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name_alternate
}

locals {
  azure_storage_share_directory_for_each_share_name              = azurerm_storage_share_directory.example_alternate_provider_with_for_each["a"].share_name
  azure_storage_share_directory_for_each_storage_account_name    = azurerm_storage_share_directory.example_alternate_provider_with_for_each["a"].storage_account_name
  azurerm_storage_share_directory_share_name                     = azurerm_storage_share_directory.example.share_name
  azurerm_storage_share_directory_share_name_alternate           = azurerm_storage_share_directory.example_alternate_provider.share_name
  azurerm_storage_share_directory_storage_account_name           = azurerm_storage_share_directory.example.storage_account_name
  azurerm_storage_share_directory_storage_account_name_alternate = azurerm_storage_share_directory.example_alternate_provider.storage_account_name
}