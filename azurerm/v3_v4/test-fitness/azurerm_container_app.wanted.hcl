resource "azurerm_container_app" "example" {
  container_app_environment_id = azurerm_container_app_environment.example.id
  name                         = "example-app"
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"

  template {
    container {
      cpu    = 0.25
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      memory = "0.5Gi"
      name   = "examplecontainerapp"
    }
  }
  ingress {
    target_port = 8080
  }
}