resource "azurerm_container_app_job" "example" {
  container_app_environment_id = azurerm_container_app_environment.example.id
  location                     = azurerm_resource_group.example.location
  name                         = "example-container-app-job"
  replica_timeout_in_seconds   = 10
  resource_group_name          = azurerm_resource_group.example.name
  replica_retry_limit          = 10

  template {
    container {
      cpu    = 0.5
      image  = "repo/testcontainerAppsJob0:v1"
      memory = "1Gi"
      name   = "testcontainerappsjob0"

      liveness_probe {
        port                    = 5000
        transport               = "HTTP"
        failure_count_threshold = 1
        initial_delay           = 5
        interval_seconds        = 20
        path                    = "/health"
        timeout                 = 2

        header {
          name  = "Cache-Control"
          value = "no-cache"
        }
      }
      readiness_probe {
        port      = 5000
        transport = "HTTP"
      }
      startup_probe {
        port      = 5000
        transport = "TCP"
      }
    }
  }
  manual_trigger_config {
    parallelism              = 4
    replica_completion_count = 1
  }
  registry {
    password_secret_name = "mypassword"
    username             = "myuser"
  }
  dynamic "secret" {
    for_each = var.secret_value == null ? [] : [var.secret_value]
    iterator = secrets

    content {
      name  = "secret"
      value = sensitive(secrets.value)
    }
  }
}

locals {
  azurerm_container_app_job_registries_username = azurerm_container_app_job.example.registry[0].username
  azurerm_container_app_job_secrets_value       = azurerm_container_app_job.example.secret[0].value
}