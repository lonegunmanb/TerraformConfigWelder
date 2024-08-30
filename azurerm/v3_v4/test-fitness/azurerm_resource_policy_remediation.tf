resource "azurerm_resource_policy_remediation" "example" {
  name                 = "remediation1"
  policy_assignment_id = azurerm_resource_group_policy_assignment.example.id
  resource_id          = azurerm_virtual_network.example.id
  policy_definition_id = var.azurerm_resource_policy_remediation_policy_definition_id
}

locals {
  azurerm_resource_policy_remediation_policy_definition_id = azurerm_resource_policy_remediation.example.policy_definition_id
}