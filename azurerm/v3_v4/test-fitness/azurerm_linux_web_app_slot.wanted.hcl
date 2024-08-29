resource "azurerm_linux_web_app_slot" "example" {
  app_service_id = azurerm_linux_web_app.example.id
  name           = "example-slot"

  site_config {
    application_stack {}
  }

  lifecycle {
    ignore_changes = [site_config[0].application_stack[0].docker_registry_password, site_config[0].application_stack[0].docker_registry_url, site_config[0].application_stack[0].docker_registry_username, site_config[0].health_check_eviction_time_in_min]
  }
}