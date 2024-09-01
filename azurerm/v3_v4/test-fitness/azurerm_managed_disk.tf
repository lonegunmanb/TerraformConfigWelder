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

  encryption_settings {
    enabled = true
  }
}

locals {
  azurerm_managed_disk_encryption_settings_enabled = azurerm_managed_disk.enabled.encryption_settings[0].enabled
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

  encryption_settings {
    enabled = false
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

  encryption_settings {
    enabled = true

    disk_encryption_key {
      secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
      source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
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

  encryption_settings {
    enabled = true

    key_encryption_key {
      key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
      source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
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
    for_each = ["encryption_settings"]

    content {
      enabled = true

      key_encryption_key {
        key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
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
    for_each = ["encryption_settings"]
    iterator = enc

    content {
      enabled = true

      key_encryption_key {
        key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
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

  encryption_settings {
    enabled = true

    dynamic "disk_encryption_key" {
      for_each = ["disk_encryption_key"]

      content {
        secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
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

  encryption_settings {
    enabled = true

    dynamic "disk_encryption_key" {
      for_each = ["disk_encryption_key"]
      iterator = dek

      content {
        secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
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

  encryption_settings {
    enabled = true

    dynamic "key_encryption_key" {
      for_each = ["key_encryption_key"]

      content {
        key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
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

  encryption_settings {
    enabled = true

    dynamic "key_encryption_key" {
      for_each = ["key_encryption_key"]
      iterator = kek

      content {
        key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
      }
    }
  }
}