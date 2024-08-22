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
  operating_system      = "Linux"

  linux {
    classification_included = "Security"
    excluded_packages       = ["apt"]
    included_packages       = ["vim"]
    reboot                  = "IfRequired"
  }

  pre_task {
    source = azurerm_automation_runbook.example.name
    parameters = {
      COMPUTER_NAME = "Foo"
    }
  }
  duration = "PT2H2M2S"
}

resource "azurerm_analysis_services_server" "server" {
  name                    = "analysisservicesserver"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  sku                     = "S0"
  admin_users             = ["myuser@domain.tld"]
  enable_power_bi_service = true

  ipv4_firewall_rule {
    name        = "myRule1"
    range_start = "210.117.252.0"
    range_end   = "210.117.252.255"
  }

  tags = {
    abc = 123
  }
}

resource "azurerm_servicebus_topic" "example" {
  count        = 1
  name         = "tfex_servicebus_topic"
  namespace_id = azurerm_servicebus_namespace.example.id

  enable_express            = true
  enable_batched_operations = true
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

resource "azurerm_kubernetes_cluster" "example" {
  count                           = 1
  name                            = "example-aks1"
  location                        = azurerm_resource_group.example.location
  resource_group_name             = azurerm_resource_group.example.name
  dns_prefix                      = "exampleaks1"
  api_server_authorized_ip_ranges = ["198.51.100.0/24"]
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    linux_os_config {
      swap_file_size_mb = 100
    }
  }
  network_profile {
    network_plugin  = "azure"
    ebpf_data_plane = "azure"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Production"
  }
}

locals {
  swap_file_size_mb = azurerm_kubernetes_cluster.example[0].default_node_pool[0].linux_os_config[0].swap_file_size_mb
  ebpf_data_plane   = one(azurerm_kubernetes_cluster.example[0].network_profile.*.ebpf_data_plane)
}

resource "azurerm_container_app_job" "example" {
  name                         = "example-container-app-job"
  location                     = azurerm_resource_group.example.location
  resource_group_name          = azurerm_resource_group.example.name
  container_app_environment_id = azurerm_container_app_environment.example.id

  replica_timeout_in_seconds = 10
  replica_retry_limit        = 10
  registries {
    username             = "myuser"
    password_secret_name = "mypassword"
  }
  dynamic "secrets" {
    for_each = var.secret_value == null ? [] : [var.secret_value]
    content {
      name  = "secret"
      value = sensitive(secrets.value)
    }
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
  dynamic "gallery_applications" {
    for_each = var.gallery_applications == null ? [] : [var.gallery_applications]
    content {
      package_reference_id             = gallery_applications.value.package_reference_id
      configuration_reference_blob_uri = gallery_applications.value.configuration_reference_blob_uri
      order                            = gallery_applications.value.order
      tag                              = gallery_applications.value.tag
    }
  }
}

locals {
  gallery_applications_package_reference_id             = azurerm_linux_virtual_machine_scale_set.example[0].gallery_applications[0].package_reference_id
  gallery_applications_configuration_reference_blob_uri = azurerm_linux_virtual_machine_scale_set.example[0].gallery_applications[0].configuration_reference_blob_uri
}

resource "azurerm_monitor_aad_diagnostic_setting" "example" {
  name               = "setting1"
  storage_account_id = azurerm_storage_account.example.id
  log {
    enabled  = true
    category = "SignInLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  log {
    enabled  = true
    category = "AuditLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  log {
    enabled  = true
    category = "NonInteractiveUserSignInLogs"
    retention_policy {
      enabled = true
      days    = 1
    }
  }
  log {
    enabled  = true
    category = "ServicePrincipalSignInLogs"
    retention_policy {
      enabled = true
      days    = 1
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
  name                                           = "example-subnet"
  resource_group_name                            = azurerm_resource_group.example.name
  virtual_network_name                           = azurerm_virtual_network.example.name
  address_prefixes                               = ["10.0.1.0/24"]
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

resource "azurerm_api_management_api" "example" {
  name                = "example-api"
  resource_group_name = azurerm_resource_group.example.name
  api_management_name = azurerm_api_management.example.name
  revision            = "1"
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]
  soap_pass_through   = var.soap_pass_through

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_count" {
  count              = 1
  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  vault_base_url     = count.index == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : ""
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  principal_id       = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_for_each" {
  for_each           = [1]
  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  vault_base_url     = each.value == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : ""
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  principal_id       = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "this" {
  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  vault_base_url     = var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  principal_id       = data.azurerm_client_config.current.object_id
  provider           = azurerm.alternate
}

resource "azurerm_automation_software_update_configuration" "linux_example" {
  name                  = "example"
  automation_account_id = azurerm_automation_account.example.id
  operating_system      = "Linux"

  linux {
    classification_included = "Security"
    excluded_packages       = ["apt"]
    included_packages       = ["vim"]
    reboot                  = "IfRequired"
  }

  pre_task {
    source = azurerm_automation_runbook.example.name
    parameters = {
      COMPUTER_NAME = "Foo"
    }
  }

  duration = "PT2H2M2S"
}

resource "azurerm_automation_software_update_configuration" "windowsexample" {
  name                  = "example"
  automation_account_id = azurerm_automation_account.example.id
  operating_system      = "Linux"

  windows {
    classification_included = "${var.windows_update_configuration_classification},Critical"
    reboot                  = "IfRequired"
  }

  pre_task {
    source = azurerm_automation_runbook.example.name
    parameters = {
      COMPUTER_NAME = "Foo"
    }
  }

  duration = "PT2H2M2S"
}

resource "azurerm_bot_channel_web_chat" "example" {
  bot_name            = azurerm_bot_channels_registration.example.name
  location            = azurerm_bot_channels_registration.example.location
  resource_group_name = azurerm_resource_group.example.name

  site_names = ["example", "example2"]
}

resource "azurerm_cdn_endpoint_custom_domain" "example" {
  name            = "example-domain"
  cdn_endpoint_id = azurerm_cdn_endpoint.example.id
  host_name       = "${azurerm_dns_cname_record.example.name}.${data.azurerm_dns_zone.example.name}"
  user_managed_https {
    key_vault_certificate_id = var.azurerm_cdn_endpoint_custom_domain_key_vault_certificate_id
  }
}

resource "azurerm_container_group" "example" {
  name                = "example-continst"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"
  network_profile_id  = var.azurerm_container_group_network_profile_id

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
  retention_policy {
    days = var.azurerm_container_registry_rention_in_days
  }
  trust_policy {
    enabled = var.azurerm_container_registry_trust_policy_enabled
  }
}

locals {
  retention_policy_days = azurerm_container_registry.acr[0].retention_policy[0].days
  trust_policy_enabled  = azurerm_container_registry.acr[0].trust_policy[0].enabled
}

resource "azurerm_cosmosdb_account" "db" {
  count               = 0
  name                = "tfex-cosmos-db-${random_integer.ri.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  automatic_failover_enabled      = true
  enable_multiple_write_locations = var.azurerm_cosmosdb_account_enable_multiple_write_locations

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
}

locals {
  azurerm_cosmosdb_account_connection_strings              = azurerm_cosmosdb_account.db[0].connection_strings
  azurerm_cosmosdb_account_enable_multiple_write_locations = azurerm_cosmosdb_account.db[0].enable_multiple_write_locations
}

resource "azurerm_cosmosdb_sql_container" "example" {
  name                  = "example-container"
  resource_group_name   = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.example.name
  database_name         = azurerm_cosmosdb_sql_database.example.name
  partition_key_path    = "/definition/id"
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
}