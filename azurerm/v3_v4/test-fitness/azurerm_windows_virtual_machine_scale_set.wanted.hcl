resource "azurerm_windows_virtual_machine_scale_set" "example" {
  count = 1

  admin_password       = "P@55w0rd1234!"
  admin_username       = "adminuser"
  instances            = 1
  location             = azurerm_resource_group.example.location
  name                 = "example-vmss"
  resource_group_name  = azurerm_resource_group.example.name
  sku                  = "Standard_F2"
  computer_name_prefix = "vm-"

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
  dynamic "gallery_application" {
    for_each = var.azurerm_windows_virtual_machine_scale_set_gallery_applications == null ? [] : [var.gallery_applications]
    iterator = gallery_applications

    content {
      version_id             = gallery_applications.value.package_reference_id
      configuration_blob_uri = gallery_applications.value.configuration_reference_blob_uri
      order                  = gallery_applications.value.order
      tag                    = gallery_applications.value.tag
    }
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2016-Datacenter-Server-Core"
    version   = "latest"
  }
  termination_notification {
    enabled = var.azurerm_windows_virtual_machine_scale_set_terminate_notification_enabled
    timeout = var.azurerm_windows_virtual_machine_scale_set_terminate_notification_timeout
  }
}


locals {
  azurerm_windows_virtual_machine_scale_set_gallery_applications_configuration_reference_blob_uri = azurerm_windows_virtual_machine_scale_set.example[0].gallery_application[0].configuration_blob_uri
  azurerm_windows_virtual_machine_scale_set_gallery_applications_package_reference_id             = azurerm_windows_virtual_machine_scale_set.example[0].gallery_application[0].version_id
  azurerm_windows_virtual_machine_scale_set_scale_in_policy                                       = azurerm_windows_virtual_machine_scale_set.example[0].scale_in[0].rule
  azurerm_windows_virtual_machine_scale_set_terminate_notification_enabled                        = azurerm_windows_virtual_machine_scale_set.example[0].termination_notification[0].enabled
  azurerm_windows_virtual_machine_scale_set_terminate_notification_timeout                        = azurerm_windows_virtual_machine_scale_set.example[0].termination_notification[0].timeout
}