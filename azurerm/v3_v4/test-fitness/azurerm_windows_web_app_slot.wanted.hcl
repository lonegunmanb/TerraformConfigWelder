resource "azurerm_windows_web_app_slot" "example" {
  app_service_id = azurerm_windows_web_app.example.id
  name           = "example-slot"

  site_config {
    application_stack {}
    auto_heal_setting {
      trigger {
        slow_request_with_path {
          count      = 0
          interval   = ""
          time_taken = ""
          path       = var.azurerm_windows_web_app_slot_site_config_auto_heal_setting_trigger_slow_request_path
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [site_config[0].application_stack[0].docker_registry_password, site_config[0].application_stack[0].docker_registry_url, site_config[0].application_stack[0].docker_registry_username, site_config[0].health_check_eviction_time_in_min]
  }
}

locals {
  azurerm_windows_web_app_slot_site_config_auto_heal_setting_trigger_slow_request_path = azurerm_windows_web_app_slot.example.site_config[0].auto_heal_setting[0].trigger[0].slow_request_with_path[0].path
}