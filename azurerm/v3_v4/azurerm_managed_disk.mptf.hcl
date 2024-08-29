locals {
  managed_disk_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_managed_disk"]) : [for b in blocks : b]])
  managed_disk_resource_blocks_map = { for block in local.managed_disk_resource_blocks : block.mptf.block_address => block }
  managed_disk_with_encryption_settings_enabled = {
    for key, block in local.managed_disk_resource_blocks_map : key => block if can(block.encryption_settings[0].enabled) && !can(block.encryption_settings[0].for_each) && !can(block.encryption_settings[0].disk_encryption_key[0].for_each) && !can(block.encryption_settings[0].key_encryption_key[0].for_each)
  }
}

transform "update_in_place" managed_disk {
  for_each             = var.azurerm_managed_disk_toggle ? local.managed_disk_with_encryption_settings_enabled : tomap({})
  target_block_address = each.key
  asstring {
    dynamic "encryption_settings" {
      for_each = "(${each.value.encryption_settings[0].enabled}) ? [\"encryption_settings\"] : []"
      content {
        dynamic "disk_encryption_key" {
          for_each = can(each.value.encryption_settings[0].disk_encryption_key[0]) ? "[\"disk_encryption_key\"]" : "[]"
          content {
            secret_url      = try(each.value.encryption_settings[0].disk_encryption_key[0].secret_url, "null")
            source_vault_id = try(each.value.encryption_settings[0].disk_encryption_key[0].source_vault_id, "null")
          }
        }
        dynmaic "key_encryption_key" {
          for_each = can(each.value.encryption_settings[0].key_encryption_key[0]) ? "[\"key_encryption_key\"]" : "[]"
          content {
            key_url         = try(each.value.encryption_settings[0].key_encryption_key[0].key_url, "null")
            source_vault_id = try(each.value.encryption_settings[0].key_encryption_key[0].source_vault_id, "null")
          }
        }
      }
    }
  }
  depends_on = [
    transform.remove_block_element.managed_disk,
  ]
}

transform "remove_block_element" managed_disk {
  for_each             = var.azurerm_managed_disk_toggle ? local.managed_disk_with_encryption_settings_enabled : tomap({})
  target_block_address = each.key
  paths                = ["encryption_settings"]
}