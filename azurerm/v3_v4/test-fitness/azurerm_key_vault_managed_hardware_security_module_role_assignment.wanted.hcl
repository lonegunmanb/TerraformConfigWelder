resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_count" {
  count = 1

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  managed_hsm_id     = one([for block in data.all_key_vault_hsm_azurerm.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (count.index == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : "")]).id

  lifecycle {
    ignore_changes = [managed_hsm_id]
  }
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_for_each" {
  for_each = [1]

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  managed_hsm_id     = one([for block in data.all_key_vault_hsm_azurerm.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (each.value == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : "")]).id

  lifecycle {
    ignore_changes = [managed_hsm_id]
  }
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "this" {
  provider = azurerm.alternate

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  managed_hsm_id     = one([for block in data.all_key_vault_hsm_azurerm_alternate.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url)]).id

  lifecycle {
    ignore_changes = [managed_hsm_id]
  }
}
data "azurerm_resources" "all_key_vault_hsm_azurerm_alternate" {
  provider = azurerm.alternate

  type = "Microsoft.KeyVault/managedHSMs"
}

data "azurerm_resources" "all_key_vault_hsm_azurerm" {
  provider = azurerm

  type = "Microsoft.KeyVault/managedHSMs"
}
