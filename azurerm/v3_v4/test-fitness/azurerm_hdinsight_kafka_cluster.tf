resource "azurerm_hdinsight_kafka_cluster" "example" {
  cluster_version     = "4.0"
  location            = azurerm_resource_group.example.location
  name                = "example-hdicluster"
  resource_group_name = azurerm_resource_group.example.name
  tier                = "Standard"

  component_version {
    kafka = "2.1"
  }
  gateway {
    password = "TerrAform123!"
    username = "acctestusrgw"
  }
  roles {
    head_node {
      username = "acctestusrvm"
      vm_size  = "Standard_D3_V2"
      password = "AccTestvdSC4daf986!"
    }
    worker_node {
      number_of_disks_per_node = 3
      target_instance_count    = 3
      username                 = "acctestusrvm"
      vm_size                  = "Standard_D3_V2"
      password                 = "AccTestvdSC4daf986!"
    }
    zookeeper_node {
      username = "acctestusrvm"
      vm_size  = "Standard_D3_V2"
      password = "AccTestvdSC4daf986!"
    }
    kafka_management_node {
      username = "acctestusrkm"
    }
  }
  storage_account {
    is_default           = true
    storage_account_key  = azurerm_storage_account.example.primary_access_key
    storage_container_id = azurerm_storage_container.example.id
  }
}