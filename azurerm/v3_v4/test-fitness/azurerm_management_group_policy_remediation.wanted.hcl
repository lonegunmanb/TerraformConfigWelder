resource "azurerm_management_group_policy_remediation" "example" {
  management_group_id            = azurerm_management_group.example.id
  name                           = "example"
  policy_assignment_id           = azurerm_management_group_policy_assignment.example.id
  policy_definition_reference_id = var.azurerm_management_group_policy_remediation_policy_definition_id
}