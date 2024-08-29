resource "azurerm_managed_application" "example" {
  kind                        = "ServiceCatalog"
  location                    = azurerm_resource_group.example.location
  managed_resource_group_name = "infrastructureGroup"
  name                        = "example-managedapplication"
  resource_group_name         = azurerm_resource_group.example.name
  application_definition_id   = azurerm_managed_application_definition.example.id
  parameter_values = jsonencode({ for k, v in {
    location                 = "eastus"
    storageAccountNamePrefix = "storeNamePrefix"
    storageAccountType       = "Standard_LRS"
  } : k => { value = v } })
}

locals {
  azurerm_managed_application_parameters_location = ({ for k, v in jsondecode(azurerm_managed_application.example.parameter_values) : k => v.value })["location"]
}