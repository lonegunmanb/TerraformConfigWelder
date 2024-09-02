resource "azurerm_windows_web_app_slot" "example" {
  app_service_id = azurerm_windows_web_app.example.id
  name           = "example-slot"

  site_config {
    application_stack {
      docker_container_name     = var.azurerm_windows_web_app_slot_site_config_application_stack_docker_container_name
      docker_container_registry = var.azurerm_windows_web_app_slot_site_config_application_stack_docker_container_registry
      docker_container_tag      = var.azurerm_windows_web_app_slot_site_config_application_stack_docker_container_tag
    }
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

locals {
  azurerm_windows_web_app_slot_site_config_auto_heal_setting_trigger_slow_request_path = azurerm_windows_web_app_slot.example.site_config[0].auto_heal_setting[0].trigger[0].slow_request[0].path
}