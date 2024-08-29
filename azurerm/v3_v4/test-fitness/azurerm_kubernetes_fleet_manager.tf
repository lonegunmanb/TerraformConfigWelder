resource "azurerm_kubernetes_fleet_manager" "example" {
  location            = azurerm_resource_group.example.location
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name

  hub_profile {
    dns_prefix = var.azurerm_kubernetes_fleet_manager_hub_profile_dns_prefix
  }
}