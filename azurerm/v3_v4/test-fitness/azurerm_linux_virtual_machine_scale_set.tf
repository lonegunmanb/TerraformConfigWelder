resource "azurerm_linux_virtual_machine_scale_set" "example" {
  count = 1

  admin_username      = "adminuser"
  location            = azurerm_resource_group.example.location
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_F2"
  instances           = 1
  scale_in_policy     = var.azurerm_linux_virtual_machine_scale_set_scale_in_policy

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_ssh_key {
    public_key = local.first_public_key
    username   = "adminuser"
  }
  dynamic "gallery_applications" {
    for_each = var.gallery_applications == null ? [] : [var.gallery_applications]

    content {
      package_reference_id             = gallery_applications.value.package_reference_id
      configuration_reference_blob_uri = gallery_applications.value.configuration_reference_blob_uri
      order                            = gallery_applications.value.order
      tag                              = gallery_applications.value.tag
    }
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts"
    version   = "latest"
  }
  terminate_notification {
    enabled = var.azurerm_linux_virtual_machine_scale_set_terminate_notification_enabled
    timeout = var.azurerm_linux_virtual_machine_scale_set_terminate_notification_timeout
  }
}

locals {
  azurerm_linux_virtual_machine_scale_set_gallery_applications_configuration_reference_blob_uri = azurerm_linux_virtual_machine_scale_set.example[0].gallery_applications[0].configuration_reference_blob_uri
  azurerm_linux_virtual_machine_scale_set_gallery_applications_package_reference_id             = azurerm_linux_virtual_machine_scale_set.example[0].gallery_applications[0].package_reference_id
  azurerm_linux_virtual_machine_scale_set_scale_in_policy                                       = azurerm_linux_virtual_machine_scale_set.example[0].scale_in_policy
  azurerm_linux_virtual_machine_scale_set_terminate_notification_enabled                        = azurerm_linux_virtual_machine_scale_set.example[0].terminate_notification[0].enabled
  azurerm_linux_virtual_machine_scale_set_terminate_notification_timeout                        = azurerm_linux_virtual_machine_scale_set.example[0].terminate_notification[0].timeout
}