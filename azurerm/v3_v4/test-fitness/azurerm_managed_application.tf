resource "azurerm_managed_application" "example" {
  kind                        = "ServiceCatalog"
  location                    = azurerm_resource_group.example.location
  managed_resource_group_name = "infrastructureGroup"
  name                        = "example-managedapplication"
  resource_group_name         = azurerm_resource_group.example.name
  application_definition_id   = azurerm_managed_application_definition.example.id
  parameters = {
    location                 = "eastus"
    storageAccountNamePrefix = "storeNamePrefix"
    storageAccountType       = "Standard_LRS"
  }
}

locals {
  azurerm_managed_application_parameters_location = azurerm_managed_application.example.parameters["location"]
}