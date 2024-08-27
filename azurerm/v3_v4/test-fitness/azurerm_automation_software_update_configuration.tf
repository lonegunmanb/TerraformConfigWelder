resource "azurerm_automation_software_update_configuration" "linux_example" {
  automation_account_id = azurerm_automation_account.example.id
  name                  = "example"
  duration              = "PT2H2M2S"
  operating_system      = "Linux"

  linux {
    classification_included = "Security"
    excluded_packages       = ["apt"]
    included_packages       = ["vim"]
    reboot                  = "IfRequired"
  }
  pre_task {
    parameters = {
      COMPUTER_NAME = "Foo"
    }
    source = azurerm_automation_runbook.example.name
  }
}

resource "azurerm_automation_software_update_configuration" "windowsexample" {
  automation_account_id = azurerm_automation_account.example.id
  name                  = "example"
  duration              = "PT2H2M2S"
  operating_system      = "Windows"

  pre_task {
    parameters = {
      COMPUTER_NAME = "Foo"
    }
    source = azurerm_automation_runbook.example.name
  }
  windows {
    classification_included = "${var.windows_update_configuration_classification},Critical"
    reboot                  = "IfRequired"
  }
}