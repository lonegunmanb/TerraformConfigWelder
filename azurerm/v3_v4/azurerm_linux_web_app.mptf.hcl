transform regex_replace_expression azurerm_linux_web_app_slow_request_dot_path {
  for_each    = var.azurerm_linux_web_app_toggle ? ["azurerm_linux_web_app_slow_request_dot_path"] : []
  regex       = "azurerm_linux_web_app\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?auto_heal_setting((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?trigger((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?slow_request((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?path"
  replacement = "azurerm_linux_web_app.$${1}$${2}$${3}$${4}$${5}auto_heal_setting{6}$${7}$${8}trigger$${9}$${10}$${11}slow_request_with_path$${12}$${13}$${14}path"
}

transform "rename_block_element" azurerm_linux_web_app_slow_request_dot_path {
  for_each = var.azurerm_linux_web_app_toggle ? ["azurerm_linux_web_app_slow_request_dot_path"] : []
  rename {
    resource_type  = "azurerm_linux_web_app"
    attribute_path = ["site_config", "auto_heal_setting", "trigger", "slow_request"]
    new_name       = "slow_request_with_path"
  }
  depends_on = [transform.regex_replace_expression.azurerm_linux_web_app_slow_request_dot_path]
}