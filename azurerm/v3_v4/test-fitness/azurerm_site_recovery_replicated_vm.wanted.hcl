resource "azurerm_site_recovery_replicated_vm" "vm-replication" {
  name                                      = "vm-replication"
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.policy.id
  recovery_vault_name                       = azurerm_recovery_services_vault.vault.name
  resource_group_name                       = azurerm_resource_group.secondary.name
  source_recovery_fabric_name               = azurerm_site_recovery_fabric.primary.name
  source_recovery_protection_container_name = azurerm_site_recovery_protection_container.primary.name
  source_vm_id                              = azurerm_virtual_machine.vm.id
  target_recovery_fabric_id                 = azurerm_site_recovery_fabric.secondary.id
  target_recovery_protection_container_id   = azurerm_site_recovery_protection_container.secondary.id
  target_resource_group_id                  = azurerm_resource_group.secondary.id

  managed_disk {
    disk_id                    = azurerm_virtual_machine.vm.storage_os_disk[0].managed_disk_id
    staging_storage_account_id = azurerm_storage_account.primary.id
    target_disk_type           = "Premium_LRS"
    target_replica_disk_type   = "Premium_LRS"
    target_resource_group_id   = azurerm_resource_group.secondary.id
  }
  network_interface {
    recovery_public_ip_address_id = azurerm_public_ip.secondary.id
    source_network_interface_id   = azurerm_network_interface.vm.id
    target_subnet_name            = azurerm_subnet.secondary.name
  }

  depends_on = [
    azurerm_site_recovery_protection_container_mapping.container-mapping,
    azurerm_site_recovery_network_mapping.network-mapping,
  ]
}