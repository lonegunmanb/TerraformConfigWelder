locals {
  key_vault_managed_hardware_security_module_role_assignment_resource_blocks          = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_key_vault_managed_hardware_security_module_role_assignment"]) : [for b in blocks : b]])
  key_vault_managed_hardware_security_module_role_assignment_resource_block_providers = toset([for _, block in local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map : try(block.provider, "azurerm")])
  key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map      = { for block in local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks : block.mptf.block_address => block if can(block.vault_base_url) && !can(block.managed_hsm_id) }
  key_vault_managed_hardware_security_module_role_assignment_resource_addresses       = keys(local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map)
}

transform "new_block" key_vault_managed_hardware_security_module_role_assignment {
  for_each       = var.azurerm_key_vault_managed_hardware_security_module_role_assignment_toggle && length(local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks) > 0 ? sort(distinct(concat(tolist(local.key_vault_managed_hardware_security_module_role_assignment_resource_block_providers), ["azurerm"]))) : []
  new_block_type = "data"
  filename       = local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks[0].mptf.range.file_name
  labels         = ["azurerm_resources", replace("all_key_vault_hsm_${each.value}", ".", "_")]
  asstring {
    type     = "\"Microsoft.KeyVault/managedHSMs\""
    provider = each.value
  }
}

locals {
  key_vault_managed_hardware_security_module_role_assignment_hsm_data_source_block = {
    for key, block in local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map : key => replace("all_key_vault_hsm_${try(block.provider, "azurerm")}", ".", "_")
  }
}

transform "update_in_place" key_vault_managed_hardware_security_module_role_assignment {
  for_each             = var.azurerm_key_vault_managed_hardware_security_module_role_assignment_toggle ? local.key_vault_managed_hardware_security_module_role_assignment_resource_blocks_map : tomap({})
  target_block_address = each.key
  asstring {
    managed_hsm_id = "one([for block in data.${local.key_vault_managed_hardware_security_module_role_assignment_hsm_data_source_block[each.key]}.resources : block.id if \"https://$${block.name}.managedhsm.azure.net/\" == (${each.value.vault_base_url})]).id"
  }
}

transform "remove_block_element" key_vault_managed_hardware_security_module_role_assignment {
  for_each             = var.azurerm_key_vault_managed_hardware_security_module_role_assignment_toggle ? local.key_vault_managed_hardware_security_module_role_assignment_resource_addresses : []
  target_block_address = each.value
  paths                = ["vault_base_url"]
  depends_on = [
    transform.update_in_place.key_vault_managed_hardware_security_module_role_assignment,
  ]
}
