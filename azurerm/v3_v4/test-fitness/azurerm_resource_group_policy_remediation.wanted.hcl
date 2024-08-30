resource "azurerm_resource_group_policy_remediation" "example" {
  name                           = "example-policy-remediation"
  policy_assignment_id           = azurerm_resource_group_policy_assignment.example.id
  resource_group_id              = azurerm_resource_group.example.id
  location_filters               = ["West Europe"]
  policy_definition_reference_id = var.azurerm_resource_group_policy_remediation_policy_definition_id
}

locals {
  azurerm_resource_group_policy_remediation_policy_definition_id = azurerm_resource_group_policy_remediation.example.policy_definition_reference_id
}