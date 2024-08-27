resource "azurerm_automation_software_update_configuration" "linux_example" {
  automation_account_id = azurerm_automation_account.example.id
  name                  = "example"
  duration              = "PT2H2M2S"

  linux {
    classifications_included = ["Security"]
    excluded_packages        = ["apt"]
    included_packages        = ["vim"]
    reboot                   = "IfRequired"
  }
  pre_task {
    parameters = {
      COMPUTER_NAME = "Foo"
    }
    source = azurerm_automation_runbook.example.name
  }

  lifecycle {
    ignore_changes = [schedule[0].expiry_time_offset_minutes, schedule[0].next_run_offset_minutes, schedule[0].start_time_offset_minutes]
  }
}

resource "azurerm_automation_software_update_configuration" "windowsexample" {
  automation_account_id = azurerm_automation_account.example.id
  name                  = "example"
  duration              = "PT2H2M2S"

  pre_task {
    parameters = {
      COMPUTER_NAME = "Foo"
    }
    source = azurerm_automation_runbook.example.name
  }
  windows {
    classifications_included = ["${var.windows_update_configuration_classification},Critical"]
    reboot                   = "IfRequired"
  }

  lifecycle {
    ignore_changes = [schedule[0].expiry_time_offset_minutes, schedule[0].next_run_offset_minutes, schedule[0].start_time_offset_minutes]
  }
}