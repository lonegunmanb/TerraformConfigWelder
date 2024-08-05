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
  swap_file_size_mb = azurerm_kubernetes_cluster.example[0].default_node_pool[0].linux_os_config[0].fake_block[0].swap_file_size_mb
}