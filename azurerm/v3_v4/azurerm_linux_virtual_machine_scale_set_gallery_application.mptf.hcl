transform regex_replace_expression azurerm_linux_virtual_machine_scale_set_gallery_application {
  for_each = tomap({
    "package_reference_id" : "version_id",
    "configuration_reference_blob_uri" : "configuration_blob_uri",
  })
  regex       = "azurerm_linux_virtual_machine_scale_set\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?gallery_applications((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?${each.key}"
  replacement = "azurerm_linux_virtual_machine_scale_set.$${1}$${2}$${3}$${4}$${5}gallery_application$${6}$${7}$${8}${each.value}"
}