resource "azurerm_linux_web_app" "example" {
  location            = azurerm_service_plan.example.location
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  dynamic "site_config" {
    for_each = [1]

    content {
      application_stack {}
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
    ignore_changes = [site_config[0].application_stack[0].docker_registry_password, site_config[0].application_stack[0].docker_registry_url, site_config[0].application_stack[0].docker_registry_username, site_config[0].health_check_eviction_time_in_min]
  }
}