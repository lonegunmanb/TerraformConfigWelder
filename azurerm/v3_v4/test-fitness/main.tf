resource "azurerm_virtual_network" "this" {
  address_space       = []
  location            = ""
  name                = ""
  resource_group_name = ""
}

resource "azurerm_servicebus_namespace" "example" {
  location            = azurerm_resource_group.example.location
  name                = "tfex-servicebus-namespace"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  tags = {
    source = "terraform"
  }
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

resource "azurerm_servicebus_topic" "example" {
  count = 1

  name                      = "tfex_servicebus_topic"
  namespace_id              = azurerm_servicebus_namespace.example.id
  enable_batched_operations = true
  enable_express            = true
  enable_partitioning       = true
}

output "topic_express_enabled" {
  value = azurerm_servicebus_topic.example[0].enable_express
}

output "topic_batched_operations_enabled" {
  value = azurerm_servicebus_topic.example[0].enable_batched_operations
}

output "topic_partitioning_enabled" {
  value = azurerm_servicebus_topic.example[0].enable_partitioning
}

resource "azurerm_monitor_aad_diagnostic_setting" "example" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id

  log {
    category = "SignInLogs"
    enabled  = true

    retention_policy {
      days    = 1
      enabled = true
    }
  }
  log {
    category = "AuditLogs"
    enabled  = true

    retention_policy {
      days    = 1
      enabled = true
    }
  }
  log {
    category = "NonInteractiveUserSignInLogs"
    enabled  = true

    retention_policy {
      days    = 1
      enabled = true
    }
  }
  log {
    category = "ServicePrincipalSignInLogs"
    enabled  = true

    retention_policy {
      days    = 1
      enabled = true
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

locals {
  enabled_log = azurerm_monitor_aad_diagnostic_setting.example.log[0]
}

module "mod" {
  source = "./sub_module"
  kubernetes_cluster_default_node_pool = {
    name    = "default"
    vm_size = "Standard_D2_v2"
  }
  kubernetes_cluster_location            = "eastus"
  kubernetes_cluster_name                = "test"
  kubernetes_cluster_resource_group_name = "testrg"
  kubernetes_cluster_dns_prefix          = "test"
  kubernetes_cluster_identity = {
    type = "SystemAssigned"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_subnet" "example" {
  address_prefixes                               = ["10.0.1.0/24"]
  name                                           = "example-subnet"
  resource_group_name                            = azurerm_resource_group.example.name
  virtual_network_name                           = azurerm_virtual_network.example.name
  enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  enforce_private_link_service_network_policies  = var.enforce_private_link_service_network_policies
  private_endpoint_network_policies_enabled      = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled  = var.private_link_service_network_policies_enabled

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_linux_web_app" "example" {
  location            = azurerm_service_plan.example.location
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  #   site_config {
  #     auto_heal_setting {
  #       trigger {
  #         slow_request {
  #           count      = 0
  #           interval   = ""
  #           time_taken = ""
  #           path = var.azurerm_linux_web_app_site_config_auto_heal_setting_trigger_slow_request_path
  #         }
  #       }
  #     }
  #   }
  dynamic "site_config" {
    for_each = [1]

    content {
      auto_heal_setting {
        trigger {
          slow_request {
            count      = 0
            interval   = ""
            time_taken = ""
            path       = var.azurerm_linux_web_app_site_config_auto_heal_setting_trigger_slow_request_path
          }
        }
      }
    }
  }
}

resource "azurerm_machine_learning_workspace" "example" {
  count = 1

  application_insights_id                      = azurerm_application_insights.example.id
  key_vault_id                                 = azurerm_key_vault.example.id
  location                                     = azurerm_resource_group.example.location
  name                                         = "example-workspace"
  resource_group_name                          = azurerm_resource_group.example.name
  storage_account_id                           = azurerm_storage_account.example.id
  public_access_behind_virtual_network_enabled = var.azurerm_machine_learning_workspace_public_access_behind_virtual_network_enabled

  identity {
    type = "SystemAssigned"
  }
}

locals {
  azurerm_machine_learning_workspace_public_access_behind_virtual_network_enabled = azurerm_machine_learning_workspace.example[0].public_access_behind_virtual_network_enabled
}

resource "azurerm_managed_application" "example" {
  kind                        = "ServiceCatalog"
  location                    = azurerm_resource_group.example.location
  managed_resource_group_name = "infrastructureGroup"
  name                        = "example-managedapplication"
  resource_group_name         = azurerm_resource_group.example.name
  application_definition_id   = azurerm_managed_application_definition.example.id
  parameters = {
    location                 = "eastus"
    storageAccountNamePrefix = "storeNamePrefix"
    storageAccountType       = "Standard_LRS"
  }
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

resource "azurerm_route_table" "example" {
  location                      = "eastus"
  name                          = "route_table"
  resource_group_name           = "rg"
  disable_bgp_route_propagation = var.azurerm_route_table_disable_bgp_route_propagation
}

resource "azurerm_sentinel_alert_rule_scheduled" "example" {
  display_name               = "example"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.example.workspace_id
  name                       = "example"
  query                      = <<QUERY
AzureActivity |
  where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
  where ActivityStatus == "Succeeded" |
  make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
QUERY
  severity                   = "High"

  incident_configuration {
    create_incident         = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_create_incident
    group_by_alert_details  = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_alert_details
    group_by_custom_details = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_custom_details
    group_by_entities       = var.azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_entities
  }
}

locals {
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_create_incident         = azurerm_sentinel_alert_rule_scheduled.example.incident_configuration[0].create_incident
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_alert_details  = azurerm_sentinel_alert_rule_scheduled.example.incident_configuration[0].group_by_alert_details
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_custom_details = azurerm_sentinel_alert_rule_scheduled.example.incident_configuration[0].group_by_custom_details
  azurerm_sentinel_alert_rule_scheduled_incident_configuration_group_by_entities       = azurerm_sentinel_alert_rule_scheduled.example.incident_configuration[0].group_by_entities
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "singleton" {
  customer_managed_key_enabled = false
  resource_group_name          = var.azurerm_sentinel_log_analytics_workspace_onboarding_resource_group_name
  workspace_name               = var.azurerm_sentinel_log_analytics_workspace_onboarding_workspace_name
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "count" {
  count = var.azurerm_sentinel_log_analytics_workspace_onboarding_count

  customer_managed_key_enabled = false
  resource_group_name          = local.azurerm_sentinel_log_analytics_workspace_onboarding_count_rg_names[count.index]
  workspace_name               = local.azurerm_sentinel_log_analytics_workspace_onboarding_count_names[count.index]
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "for_each" {
  for_each = var.azurerm_sentinel_log_analytics_workspace_onboarding_for_each

  customer_managed_key_enabled = false
  resource_group_name          = each.value
  workspace_name               = each.value
}

locals {
  azurerm_sentinel_log_analytics_workspace_onboarding_count_workspace_name         = azurerm_sentinel_log_analytics_workspace_onboarding.count[0].workspace_name
  azurerm_sentinel_log_analytics_workspace_onboarding_for_each_resource_group_name = azurerm_sentinel_log_analytics_workspace_onboarding.for_each["a"].resource_group_name
}

resource "azurerm_storage_share_directory" "singleton" {
  name                 = "example"
  share_name           = var.azurerm_storage_share_directory_share_name
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name
}

resource "azurerm_storage_share_directory" "count" {
  count = var.azurerm_storage_share_directory_count

  name                 = "example"
  share_name           = var.azurerm_storage_share_directory_share_name
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name
}

resource "azurerm_storage_share_directory" "for_each" {
  for_each = var.azurerm_storage_share_directory_for_each

  name                 = "example"
  share_name           = var.azurerm_storage_share_directory_share_name
  storage_account_name = var.azurerm_storage_share_directory_storage_account_name
}

locals {
  azurerm_storage_share_directory_count_storage_name  = azurerm_storage_share_directory.count[0].storage_account_name
  azurerm_storage_share_directory_for_each_share_name = azurerm_storage_share_directory.for_each["a"].share_name
}

resource "azurerm_storage_table_entity" "singleton" {
  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_storage_account_name
  table_name           = var.azurerm_storage_table_entity_storage_table_name
}

resource "azurerm_storage_table_entity" "count" {
  count = var.azurerm_storage_table_entity_count

  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_storage_account_name
  table_name           = var.azurerm_storage_table_entity_storage_table_name
}

resource "azurerm_storage_table_entity" "for_each" {
  for_each = var.azurerm_storage_table_entity_for_each

  entity = {
    example = "example"
  }
  partition_key        = "examplepartition"
  row_key              = "examplerow"
  storage_account_name = var.azurerm_storage_table_entity_storage_account_name
  table_name           = var.azurerm_storage_table_entity_storage_table_name
}

locals {
  azurerm_storage_table_entity_count_storage_name  = azurerm_storage_table_entity.count[0].storage_account_name
  azurerm_storage_table_entity_for_each_table_name = azurerm_storage_table_entity.for_each["a"].table_name
}

resource "azurerm_vpn_gateway_nat_rule" "external_mapping" {
  name                            = "example-vpngatewaynatrule"
  resource_group_name             = var.azurerm_vpn_gateway_nat_rule_resource_group_name
  vpn_gateway_id                  = azurerm_vpn_gateway.example.id
  external_address_space_mappings = ["192.168.21.0/26"]
}

resource "azurerm_vpn_gateway_nat_rule" "internal_mapping" {
  name                            = "example-vpngatewaynatrule"
  resource_group_name             = var.azurerm_vpn_gateway_nat_rule_resource_group_name
  vpn_gateway_id                  = azurerm_vpn_gateway.example.id
  internal_address_space_mappings = ["192.168.21.0/26"]
}

locals {
  azurerm_vpn_gateway_nat_rule_external_address_space_mappings = azurerm_vpn_gateway_nat_rule.external_mapping.external_address_space_mappings
  azurerm_vpn_gateway_nat_rule_internal_address_space_mappings = azurerm_vpn_gateway_nat_rule.internal_mapping.internal_address_space_mappings
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