resource "azurerm_linux_web_app_slot" "example" {
  app_service_id = azurerm_linux_web_app.example.id
  name           = "example-slot"

  site_config {
    application_stack {
      docker_image     = var.azurerm_linux_web_app_slot_site_config_application_stack_docker_image
      docker_image_tag = var.azurerm_linux_web_app_slot_site_config_application_stack_docker_image_tag
    }
  }
}