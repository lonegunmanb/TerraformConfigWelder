transform regex_replace_expression azurerm_windows_web_app_slow_request_dot_path {
  for_each    = var.azurerm_windows_web_app_toggle ? ["azurerm_windows_web_app_slow_request_dot_path"] : []
  regex       = "azurerm_windows_web_app\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?site_config((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?auto_heal_setting((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?trigger((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?slow_request((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?path"
  replacement = "azurerm_windows_web_app.$${1}$${2}$${3}$${4}$${5}site_config$${6}$${7}$${8}auto_heal_setting$${9}$${10}$${11}trigger$${12}$${13}$${14}slow_request_with_path$${15}$${16}$${17}path"
}

transform "rename_block_element" azurerm_windows_web_app_slow_request_dot_path {
  for_each = var.azurerm_windows_web_app_toggle ? ["azurerm_windows_web_app_slow_request_dot_path"] : []
  rename {
    resource_type  = "azurerm_windows_web_app"
    attribute_path = ["site_config", "auto_heal_setting", "trigger", "slow_request"]
    new_name       = "slow_request_with_path"
  }
  depends_on = [transform.regex_replace_expression.azurerm_windows_web_app_slow_request_dot_path]
}