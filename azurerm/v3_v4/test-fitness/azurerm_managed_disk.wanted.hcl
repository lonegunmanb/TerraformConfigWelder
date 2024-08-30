resource "azurerm_managed_disk" "enabled" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "disabled" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "disabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (false) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "disk_encryption_key" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = ["disk_encryption_key"]
        iterator = disk_encryption_key

        content {
          secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
        }
      }
      dynmaic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "key_encryption_key" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "dynamic_encryption_settings" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = try((true) ? { for k, v in(["encryption_settings"]) : k => v } : tomap({}), (true) ? (["encryption_settings"]) : toset([]))
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "dynamic_encryption_settings_with_iterator" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = try((true) ? { for k, v in(["encryption_settings"]) : k => v } : tomap({}), (true) ? (["encryption_settings"]) : toset([]))
    iterator = enc

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "dynamic_disk_encryption_key" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = ["disk_encryption_key"]
        iterator = disk_encryption_key

        content {
          secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
        }
      }
      dynmaic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "dynamic_disk_encryption_key_with_iterator" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = ["disk_encryption_key"]
        iterator = dek

        content {
          secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
        }
      }
      dynmaic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "dynamic_key_encryption_key" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
        }
      }
    }
  }
}

resource "azurerm_managed_disk" "dynamic_key_encryption_key_with_iterator" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynmaic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = kek

        content {
          key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
        }
      }
    }
  }
}