resource "azurerm_subscription_policy_remediation" "example" {
  name                           = "example"
  policy_assignment_id           = azurerm_subscription_policy_assignment.example.id
  subscription_id                = data.azurerm_subscription.example.id
  policy_definition_reference_id = var.azurerm_subscription_policy_remediation_policy_definition_id
}

locals {
  azurem_subscription_policy_remediation_policy_definition_id = azurerm_subscription_policy_remediation.example.policy_definition_reference_id
}