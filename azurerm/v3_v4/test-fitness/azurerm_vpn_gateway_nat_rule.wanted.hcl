resource "azurerm_vpn_gateway_nat_rule" "external_mapping" {
  name           = "example-vpngatewaynatrule"
  vpn_gateway_id = azurerm_vpn_gateway.example.id

  dynamic "external_mapping" {
    for_each = ["192.168.21.0/26"]

    content {
      address_space = external_mapping.value
    }
  }

  lifecycle {
    ignore_changes = [external_mapping, internal_mapping]
  }
}

resource "azurerm_vpn_gateway_nat_rule" "internal_mapping" {
  name           = "example-vpngatewaynatrule"
  vpn_gateway_id = azurerm_vpn_gateway.example.id

  dynamic "internal_mapping" {
    for_each = ["192.168.21.0/26"]

    content {
      address_space = internal_mapping.value
    }
  }

  lifecycle {
    ignore_changes = [external_mapping, internal_mapping]
  }
}

locals {
  azurerm_vpn_gateway_nat_rule_external_address_space_mappings = (azurerm_vpn_gateway_nat_rule.external_mapping.external_mapping[*].address_space)
  azurerm_vpn_gateway_nat_rule_internal_address_space_mappings = (azurerm_vpn_gateway_nat_rule.internal_mapping.internal_mapping[*].address_space)
}
