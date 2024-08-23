locals {
  linux_web_app_resource_blocks     = flatten([for _, blocks in flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if resource_type == "azurerm_linux_web_app"]) : [for b in blocks : b]])
  linux_web_app_resource_blocks_map = { for block in local.linux_web_app_resource_blocks : block.mptf.block_address => block }
  linux_web_app_with_slow_request_dot_path_only = {
    for key, block in local.linux_web_app_resource_blocks_map : key => block if can(block.site_config[0].auto_heal_setting[0].trigger[0].slow_request[0].path) && !can(block.site_config[0].auto_heal_setting[0].trigger[0].slow_request_with_path[0].path)
  }
}

transform regex_replace_expression azurerm_linux_web_app_slow_request_dot_path {
  for_each    = var.azurerm_linux_web_app_toggle ? ["azurerm_linux_web_app_slow_request_dot_path"] : []
  regex       = "azurerm_linux_web_app\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?auto_heal_setting((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?trigger((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?slow_request((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?path"
  replacement = "azurerm_linux_web_app.$${1}$${2}$${3}$${4}$${5}auto_heal_setting{6}$${7}$${8}trigger$${9}$${10}$${11}slow_request_with_path$${12}$${13}$${14}path"
}

transform "rename_block_element" azurerm_linux_web_app_slow_request_dot_path {
  for_each             = var.azurerm_linux_web_app_toggle ? ["azurerm_linux_web_app_slow_request_dot_path"] : []
  rename {
    resource_type  = "azurerm_linux_web_app"
    attribute_path = ["site_config", "auto_heal_setting", "trigger", "slow_request"]
    new_name       = "slow_request_with_path"
  }
  depends_on = [transform.regex_replace_expression.azurerm_linux_web_app_slow_request_dot_path]
}