resource "azurerm_virtual_network" "this" {
  address_space       = []
  location            = ""
  name                = ""
  resource_group_name = ""
}

resource "azurerm_servicebus_namespace" "example" {
  name                = "tfex-servicebus-namespace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_automation_software_update_configuration" "example" {
  name                  = "example"
  automation_account_id = azurerm_automation_account.example.id

  linux {
    excluded_packages        = ["apt"]
    included_packages        = ["vim"]
    reboot                   = "IfRequired"
    classifications_included = ["Security"]
  }

  pre_task {
    source = azurerm_automation_runbook.example.name
    parameters = {
      COMPUTER_NAME = "Foo"
    }
  }
  duration = "PT2H2M2S"
  lifecycle {
    ignore_changes = [target.azure_query.tag_filter, schedule.start_time_offset_minutes, schedule.next_run_offset_minutes, schedule.expiry_time_offset_minutes]


  }
}

resource "azurerm_analysis_services_server" "server" {
  name                = "analysisservicesserver"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "S0"
  admin_users         = ["myuser@domain.tld"]

  ipv4_firewall_rule {
    name        = "myRule1"
    range_start = "210.117.252.0"
    range_end   = "210.117.252.255"
  }

  tags = {
    abc = 123
  }
  power_bi_service_enabled = true
}

resource "azurerm_servicebus_topic" "example" {
  count        = 1
  name         = "tfex_servicebus_topic"
  namespace_id = azurerm_servicebus_namespace.example.id

  lifecycle {
    ignore_changes = [partitioning_enabled, batched_operations_enabled, express_enabled]


  }
  batched_operations_enabled = true
  express_enabled            = true
  partitioning_enabled       = true
}

output "topic_express_enabled" {
  value = azurerm_servicebus_topic.example[0].express_enabled
}

output "topic_batched_operations_enabled" {
  value = azurerm_servicebus_topic.example[0].batched_operations_enabled
}

output "topic_partitioning_enabled" {
  value = azurerm_servicebus_topic.example[0].partitioning_enabled
}

resource "azurerm_kubernetes_cluster" "example" {
  count               = 1
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    linux_os_config {
      swap_file_size_mb = 100
    }
  }
  network_profile {
    network_plugin     = "azure"
    network_data_plane = "azure"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Production"
  }
  authorized_ip_ranges = ["198.51.100.0/24"]
  lifecycle {
    ignore_changes = [api_server_access_profile, network_profile[0].load_balancer_profile[0].outbound_ip_prefix_ids]


  }
}

locals {
  swap_file_size_mb = azurerm_kubernetes_cluster.example[0].default_node_pool[0].linux_os_config[0].swap_file_size_mb
  ebpf_data_plane   = one(azurerm_kubernetes_cluster.example[0].network_profile.*.network_data_plane)
}

resource "azurerm_container_app_job" "example" {
  name                         = "example-container-app-job"
  location                     = azurerm_resource_group.example.location
  resource_group_name          = azurerm_resource_group.example.name
  container_app_environment_id = azurerm_container_app_environment.example.id

  replica_timeout_in_seconds = 10
  replica_retry_limit        = 10
  registry {
    username             = "myuser"
    password_secret_name = "mypassword"
  }
  dynamic "secret" {
    for_each = var.secret_value == null ? [] : [var.secret_value]
    content {
      name  = "secret"
      value = sensitive(secrets.value)
    }
    iterator = secrets
  }
  manual_trigger_config {
    parallelism              = 4
    replica_completion_count = 1
  }

  template {
    container {
      image = "repo/testcontainerAppsJob0:v1"
      name  = "testcontainerappsjob0"
      readiness_probe {
        transport = "HTTP"
        port      = 5000
      }

      liveness_probe {
        transport = "HTTP"
        port      = 5000
        path      = "/health"

        header {
          name  = "Cache-Control"
          value = "no-cache"
        }

        initial_delay           = 5
        interval_seconds        = 20
        timeout                 = 2
        failure_count_threshold = 1
      }
      startup_probe {
        transport = "TCP"
        port      = 5000
      }

      cpu    = 0.5
      memory = "1Gi"
    }
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  count               = 1
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = local.first_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
  dynamic "gallery_application" {
    for_each = var.gallery_applications == null ? [] : [var.gallery_applications]
    content {
      order                  = gallery_applications.value.order
      tag                    = gallery_applications.value.tag
      version_id             = gallery_applications.value.package_reference_id
      configuration_blob_uri = gallery_applications.value.configuration_reference_blob_uri
    }
    iterator = gallery_applications
  }
  scale_in_policy = var.azurerm_linux_virtual_machine_scale_set_scale_in_policy
  scale_in {
    rule = var.azurerm_linux_virtual_machine_scale_set_scale_in_policy
  }
}

locals {
  gallery_applications_package_reference_id               = azurerm_linux_virtual_machine_scale_set.example[0].gallery_application[0].package_reference_id
  gallery_applications_configuration_reference_blob_uri   = azurerm_linux_virtual_machine_scale_set.example[0].gallery_application[0].configuration_reference_blob_uri
  azurerm_linux_virtual_machine_scale_set_scale_in_policy = azurerm_linux_virtual_machine_scale_set.example[0].scale_in[0].rule
}

resource "azurerm_monitor_aad_diagnostic_setting" "example" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id
  enabled_log {
    category = "SignInLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  enabled_log {
    category = "AuditLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  enabled_log {
    category = "NonInteractiveUserSignInLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  enabled_log {
    category = "ServicePrincipalSignInLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  lifecycle {
    ignore_changes = [enabled_log]


  }
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  enabled_log {
    category = "AuditEvent"
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
  enabled_log = azurerm_monitor_aad_diagnostic_setting.example.enabled_log[0]
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
  name                                          = "example-subnet"
  resource_group_name                           = azurerm_resource_group.example.name
  virtual_network_name                          = azurerm_virtual_network.example.name
  address_prefixes                              = ["10.0.1.0/24"]
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
  private_endpoint_network_policies = (var.subnet_enforce_private_link_endpoint_network_policies != null || var.private_endpoint_network_policies_enabled != null || false) ? (var.private_endpoint_network_policies_enabled != null ? (var.private_endpoint_network_policies_enabled ? ("Enabled") : ("Disabled")) : ((var.subnet_enforce_private_link_endpoint_network_policies != null) ? (var.subnet_enforce_private_link_endpoint_network_policies ? ("Disabled") : ("Enabled")) : (null))) : ("Enabled")
}

resource "azurerm_api_management_api" "example" {
  name                = "example-api"
  resource_group_name = azurerm_resource_group.example.name
  api_management_name = azurerm_api_management.example.name
  revision            = "1"
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
  api_type = ((var.soap_pass_through) == null) ? ("http") : ((var.soap_pass_through) ? "soap" : "http")
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_count" {
  count              = 1
  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  principal_id       = data.azurerm_client_config.current.object_id
  lifecycle {
    ignore_changes = [managed_hsm_id]


  }
  managed_hsm_id = one([for block in all_key_vault_hsm_azurerm.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (count.index == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : "")]).id
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_for_each" {
  for_each           = [1]
  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  principal_id       = data.azurerm_client_config.current.object_id
  lifecycle {
    ignore_changes = [managed_hsm_id]


  }
  managed_hsm_id = one([for block in all_key_vault_hsm_azurerm.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (each.value == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : "")]).id
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "this" {
  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  principal_id       = data.azurerm_client_config.current.object_id
  provider           = azurerm.alternate
  lifecycle {
    ignore_changes = [managed_hsm_id]


  }
  managed_hsm_id = one([for block in all_key_vault_hsm_azurerm_alternate.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url)]).id
}

resource "azurerm_automation_software_update_configuration" "linux_example" {
  name                  = "example"
  automation_account_id = azurerm_automation_account.example.id

  linux {
    excluded_packages        = ["apt"]
    included_packages        = ["vim"]
    reboot                   = "IfRequired"
    classifications_included = ["Security"]
  }

  pre_task {
    source = azurerm_automation_runbook.example.name
    parameters = {
      COMPUTER_NAME = "Foo"
    }
  }

  duration = "PT2H2M2S"
  lifecycle {
    ignore_changes = [target.azure_query.tag_filter, schedule.start_time_offset_minutes, schedule.next_run_offset_minutes, schedule.expiry_time_offset_minutes]


  }
}

resource "azurerm_automation_software_update_configuration" "windowsexample" {
  name                  = "example"
  automation_account_id = azurerm_automation_account.example.id

  windows {
    reboot                   = "IfRequired"
    classifications_included = ["${var.windows_update_configuration_classification},Critical"]
  }

  pre_task {
    source = azurerm_automation_runbook.example.name
    parameters = {
      COMPUTER_NAME = "Foo"
    }
  }

  duration = "PT2H2M2S"
  lifecycle {
    ignore_changes = [target.azure_query.tag_filter, schedule.start_time_offset_minutes, schedule.next_run_offset_minutes, schedule.expiry_time_offset_minutes]


  }
}

resource "azurerm_bot_channel_web_chat" "example" {
  bot_name            = azurerm_bot_channels_registration.example.name
  location            = azurerm_bot_channels_registration.example.location
  resource_group_name = azurerm_resource_group.example.name

  lifecycle {
    ignore_changes = [site]


  }
  dynamic "site" {
    for_each = ["example", "example2"]
    content {
      name = site.value
    }
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "example" {
  name            = "example-domain"
  cdn_endpoint_id = azurerm_cdn_endpoint.example.id
  host_name       = "${azurerm_dns_cname_record.example.name}.${data.azurerm_dns_zone.example.name}"
  user_managed_https {
    key_vault_secret_id = var.azurerm_cdn_endpoint_custom_domain_key_vault_certificate_id
  }
  lifecycle {
    ignore_changes = [user_managed_https.key_vault_secret_id]


  }
}

resource "azurerm_container_group" "example" {
  name                = "example-continst"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "testing"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  retention_policy {
    days = var.azurerm_container_registry_rention_in_days
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  trust_policy_enabled     = var.azurerm_container_registry_trust_policy_enabled
  retention_policy_in_days = var.azurerm_container_registry_rention_in_days
}

locals {
  retention_policy_days = azurerm_container_registry.acr[0].retention_policy_in_days
  trust_policy_enabled  = azurerm_container_registry.acr[0].trust_policy_enabled
}

resource "azurerm_cosmosdb_account" "db" {
  count               = 0
  name                = "tfex-cosmos-db-${random_integer.ri.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  automatic_failover_enabled = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = "eastus"
    failover_priority = 1
  }

  geo_location {
    location          = "westus"
    failover_priority = 0
  }
  multiple_write_locations_enabled = var.azurerm_cosmosdb_account_enable_multiple_write_locations
}

locals {
  azurerm_cosmosdb_account_connection_strings              = compact([try(azurerm_cosmosdb_account.db[0].primary_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].primary_readonly_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_readonly_sql_connection_string, ""), try(azurerm_cosmosdb_account.db[0].primary_mongodb_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_mongodb_connection_string, ""), try(azurerm_cosmosdb_account.db[0].primary_readonly_mongodb_connection_string, ""), try(azurerm_cosmosdb_account.db[0].secondary_readonly_mongodb_connection_string, "")])
  azurerm_cosmosdb_account_enable_multiple_write_locations = azurerm_cosmosdb_account.db[0].multiple_write_locations_enabled
}

resource "azurerm_cosmosdb_sql_container" "example" {
  name                  = "example-container"
  resource_group_name   = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.example.name
  database_name         = azurerm_cosmosdb_sql_database.example.name
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
  lifecycle {
    ignore_changes = [partition_key_paths]


  }
  partition_key_paths = ["/definition/id"]
}

resource "azurerm_databricks_workspace" "example" {
  name                                  = "databricks-test"
  resource_group_name                   = azurerm_resource_group.example.name
  location                              = azurerm_resource_group.example.location
  sku                                   = "standard"
  network_security_group_rules_required = "AllRules"

  tags = {
    Environment = "Production"
  }
  lifecycle {
    ignore_changes = [network_security_group_rules_required]


  }
}

resource "azurerm_dev_test_lab" "example" {
  name                = "example-devtestlab"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    "Sydney" = "Australia"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
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
          slow_request_with_path {
            count      = 0
            interval   = ""
            time_taken = ""
            path       = var.azurerm_linux_web_app_site_config_auto_heal_setting_trigger_slow_request_path
          }
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [site_config.health_check_eviction_time_in_min, site_config.application_stack.docker_registry_url, site_config.application_stack.docker_registry_username, site_config.application_stack.docker_registry_password]


  }
}

resource "azurerm_machine_learning_workspace" "example" {
  count                   = 1
  name                    = "example-workspace"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  application_insights_id = azurerm_application_insights.example.id
  key_vault_id            = azurerm_key_vault.example.id
  storage_account_id      = azurerm_storage_account.example.id

  identity {
    type = "SystemAssigned"
  }
  public_network_access_enabled = var.azurerm_machine_learning_workspace_public_access_behind_virtual_network_enabled
}

locals {
  azurerm_machine_learning_workspace_public_access_behind_virtual_network_enabled = azurerm_machine_learning_workspace.example[0].public_network_access_enabled
}

resource "azurerm_managed_application" "example" {
  name                        = "example-managedapplication"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  kind                        = "ServiceCatalog"
  managed_resource_group_name = "infrastructureGroup"
  application_definition_id   = azurerm_managed_application_definition.example.id

  parameter_values = jsonencode({ for k, v in {
    location                 = "eastus"
    storageAccountNamePrefix = "storeNamePrefix"
    storageAccountType       = "Standard_LRS"
  } : k => { value = v } })
}
data "azurerm_resources" "all_key_vault_hsm_azurerm" {

  provider = azurerm

  type = "Microsoft.KeyVault/managedHSMs"
}

data "azurerm_resources" "all_key_vault_hsm_azurerm_alternate" {

  provider = azurerm.alternate

  type = "Microsoft.KeyVault/managedHSMs"
}

