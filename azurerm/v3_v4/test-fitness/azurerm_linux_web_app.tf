resource "azurerm_linux_web_app" "example" {
  location            = azurerm_service_plan.example.location
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  dynamic "site_config" {
    for_each = [1]

    content {
      application_stack {
        docker_image     = var.azurerm_linux_web_app_site_config_application_stack_docker_image
        docker_image_tag = var.azurerm_linux_web_app_site_config_application_stack_docker_image_tag
      }
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