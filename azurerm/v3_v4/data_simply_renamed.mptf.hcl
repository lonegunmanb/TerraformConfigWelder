locals {
  data_simply_renamed = flatten([
    for data_source_type, renames in {
      azurerm_cosmosdb_account = [
        {
          from        = "enable_multiple_write_locations"
          to          = "multiple_write_locations_enabled"
          replace_ref = true
        },
        {
          from        = "enable_free_tier "
          to          = "free_tier_enabled"
          replace_ref = true
        },
        {
          from        = "enable_automatic_failover"
          to          = "automatic_failover_enabled"
          replace_ref = true
        },
      ]
      azurerm_kubernetes_cluster = [
        {
          from        = "agent_pool_profile.enable_auto_scaling"
          to          = "auto_scaling_enabled"
          replace_ref = true
        },
        {
          from        = "agent_pool_profile.enable_node_public_ip"
          to          = "node_public_ip_enabled"
          replace_ref = true
        },
        {
          from        = "agent_pool_profile.enable_host_encryption"
          to          = "host_encryption_enabled"
          replace_ref = true
        },
      ]
      } : [
      for rename in renames : {
        data_source_type = data_source_type
        from             = rename.from
        to               = rename.to
        replace_ref      = rename.replace_ref
      }
    ]
  ])
  data_rename_with_replacement = [for item_with_replacement in [for item_with_regex in [for item in [for rename in local.data_simply_renamed : {
    data_source_type = rename.data_source_type
    paths            = split(".", rename.from)
    to               = rename.to
    } if rename.replace_ref] : {
    data_source_type = item.data_source_type
    paths            = item.paths
    to               = item.to
    regex = join("((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?", [
      for i in range(length(item.paths)) : "${item.paths[i]}"
    ])
    }] :
    {
      data_source_type = item_with_regex.data_source_type
      paths            = item_with_regex.paths
      to               = item_with_regex.to
      regex            = "data.${item_with_regex.data_source_type}\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${item_with_regex.regex}"
      replacement      = [for i, path in slice(item_with_regex.paths, 0, length(item_with_regex.paths) - 1) : "${path}$${${(i * 3 + 6)}}$${${(i * 3 + 7)}}$${${(i * 3 + 8)}}"]
    }
    ] : {
    data_source_type = item_with_replacement.data_source_type
    paths            = item_with_replacement.paths
    to               = item_with_replacement.to
    regex            = item_with_replacement.regex
    replacement      = "data.${item_with_replacement.data_source_type}.$${1}$${2}$${3}$${4}$${5}${join("", item_with_replacement.replacement)}${item_with_replacement.to}"
  }]
}

transform regex_replace_expression data_simply_renamed {
  for_each    = var.data_simply_renamed_toggle ? [for rename in local.data_rename_with_replacement : rename] : []
  regex       = each.value.regex
  replacement = each.value.replacement
}