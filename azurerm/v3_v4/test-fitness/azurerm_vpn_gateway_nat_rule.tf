resource "azurerm_vpn_gateway_nat_rule" "external_mapping" {
  name                            = "example-vpngatewaynatrule"
  resource_group_name             = var.azurerm_vpn_gateway_nat_rule_resource_group_name
  vpn_gateway_id                  = azurerm_vpn_gateway.example.id
  external_address_space_mappings = ["192.168.21.0/26"]
}

resource "azurerm_vpn_gateway_nat_rule" "internal_mapping" {
  name                            = "example-vpngatewaynatrule"
  resource_group_name             = var.azurerm_vpn_gateway_nat_rule_resource_group_name
  vpn_gateway_id                  = azurerm_vpn_gateway.example.id
  internal_address_space_mappings = ["192.168.21.0/26"]
}

locals {
  azurerm_vpn_gateway_nat_rule_external_address_space_mappings = azurerm_vpn_gateway_nat_rule.external_mapping.external_address_space_mappings
  azurerm_vpn_gateway_nat_rule_internal_address_space_mappings = azurerm_vpn_gateway_nat_rule.internal_mapping.internal_address_space_mappings
}
