resource "azurerm_virtual_network" "this" {
  address_space       = []
  location            = ""
  name                = ""
  resource_group_name = ""
}

resource "azurerm_automation_software_update_configuration" "example" {
  automation_account_id = azurerm_automation_account.example.id
  name                  = "example"
  duration              = "PT2H2M2S"
  operating_system      = "Linux"

  linux {
    classification_included = "Security"
    excluded_packages       = ["apt"]
    included_packages       = ["vim"]
    reboot                  = "IfRequired"
  }
  pre_task {
    parameters = {
      COMPUTER_NAME = "Foo"
    }
    source = azurerm_automation_runbook.example.name
  }
}



provider "azurerm" {
  features {}
}



resource "azurerm_monitor_action_group" "example" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "p0action"

  event_hub_receiver {
    name                    = "sendtoeventhub"
    event_hub_id            = var.azurerm_monitor_action_group_event_hub_receiver_event_hub_id
    subscription_id         = "00000000-0000-0000-0000-000000000000"
    use_common_alert_schema = false
  }
  dynamic "event_hub_receiver" {
    for_each = var.event_hub_receiver == null ? [] : [var.event_hub_receiver]

    content {
      name                    = "sendtoeventhub"
      event_hub_id            = event_hub_receiver.value.event_hub_id
      subscription_id         = "00000000-0000-0000-0000-000000000000"
      use_common_alert_schema = false
    }
  }
}

resource "azurerm_windows_web_app" "example" {
  location            = azurerm_service_plan.example.location
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    auto_heal_setting {
      trigger {
        slow_request {
          count      = 0
          interval   = ""
          time_taken = ""
          path       = var.azurerm_windows_web_app_site_config_auto_heal_setting_trigger_slow_request_path
        }
      }
    }
  }
}

resource "azurerm_windows_web_app_slot" "example" {
  app_service_id = azurerm_windows_web_app.example.id
  name           = "example-slot"

  site_config {
    auto_heal_setting {
      trigger {
        slow_request {
          count      = 0
          interval   = ""
          time_taken = ""
          path       = var.azurerm_windows_web_app_slot_site_config_auto_heal_setting_trigger_slow_request_path
        }
      }
    }
  }
}

data "azurerm_cosmosdb_account" "example" {
  name                = "tfex-cosmosdb-account"
  resource_group_name = "tfex-cosmosdb-account-rg"
}

locals {
  data_azurerm_cosmosdb_account_connection_strings              = data.azurerm_cosmosdb_account.example.connection_strings
  data_azurerm_cosmosdb_account_enable_multiple_write_locations = data.azurerm_cosmosdb_account.example.enable_multiple_write_locations
}

data "azurerm_kubernetes_cluster" "example" {
  name                = "myakscluster"
  resource_group_name = "my-example-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_auto_scaling    = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_auto_scaling
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_host_encryption = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_host_encryption
  data_azurerm_kubernetes_cluster_agent_pool_profile_enable_node_public_ip  = data.azurerm_kubernetes_cluster.example.agent_pool_profile[0].enable_node_public_ip
}

data "azurerm_kubernetes_cluster_node_pool" "example" {
  kubernetes_cluster_name = "existing-cluster"
  name                    = "existing"
  resource_group_name     = "existing-resource-group"
}

locals {
  data_azurerm_kubernetes_cluster_node_pool_enable_auto_scaling   = data.azurerm_kubernetes_cluster_node_pool.example.enable_auto_scaling
  data_azurerm_kubernetes_cluster_node_pool_enable_node_public_ip = data.azurerm_kubernetes_cluster_node_pool.example.enable_node_public_ip
}

data "azurerm_monitor_diagnostic_categories" "example" {
  resource_id = data.azurerm_key_vault.example.id
}

locals {
  data_azurerm_monitor_diagnostic_logs = data.azurerm_monitor_diagnostic_categories.example.logs
}

data "azurerm_network_interface" "example" {
  name                = "acctest-nic"
  resource_group_name = "networking"
}

locals {
  data_azurerm_network_interface_enable_accelerated_networking = data.azurerm_network_interface.example.enable_accelerated_networking
  data_azurerm_network_interface_enable_ip_forwarding          = data.azurerm_network_interface.example.enable_ip_forwarding
}

data "azurerm_storage_table_entity" "example" {
  partition_key    = "example-partition-key"
  row_key          = "example-row-key"
  storage_table_id = "https://example.table.core.windows.net/table1(PartitionKey='samplepartition',RowKey='samplerow')"
}

locals {
  data_azurerm_storage_table_entity_storage_account_name = data.azurerm_storage_table_entity.example.storage_account_name
  data_azurerm_storage_table_entity_table_name           = data.azurerm_storage_table_entity.example.table_name
}