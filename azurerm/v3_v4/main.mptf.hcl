data "resource" all {
}

locals {
  all_resources = { for obj in flatten([for obj in flatten([for b in data.resource.all.result.* : [for nb in b : nb]]) : [for body in obj : body]]) : obj.mptf.block_address => obj }
  #                    dot | potential new line | label[1] | potential index or splat | dot | potential new line
  middle_path_regex = "(\\.)(\\s*\\r?\\n\\s*)?"
  rename_with_replacement = [for item_with_replacement in [for item_with_regex in [for item in [for rename in local.simply_renamed : {
    resource_type = rename.resource_type
    paths         = split(".", rename.from)
    to            = rename.to
    } if rename.replace_ref] : {
    resource_type = item.resource_type
    paths         = item.paths
    to            = item.to
    regex = join("((?:\\[\\s*[^]]+\\s*\\]|\\.\\*)?)(\\.)(\\s*\\r?\\n\\s*)?", [
      for i in range(length(item.paths)) : "${item.paths[i]}"
    ])
    }] :
    {
      resource_type = item_with_regex.resource_type
      paths         = item_with_regex.paths
      to            = item_with_regex.to
      regex         = "${item_with_regex.resource_type}\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${item_with_regex.regex}"
      replacement   = [for i, path in slice(item_with_regex.paths, 0, length(item_with_regex.paths) - 1) : "${path}$${${(i * 3 + 6)}}$${${(i * 3 + 7)}}$${${(i * 3 + 8)}}"]
    }
    ] : {
    resource_type = item_with_replacement.resource_type
    paths         = item_with_replacement.paths
    to            = item_with_replacement.to
    regex         = item_with_replacement.regex
    replacement   = "${item_with_replacement.resource_type}.$${1}$${2}$${3}$${4}$${5}${join("", item_with_replacement.replacement)}${item_with_replacement.to}"
  }]
}