locals {
  enable_to_enabled = { for k, v in local.diffs :
    k => {
      renamed = [for l in try(v.renamed == null ? [] : v.renamed) : l
    if("enable_${l[0]}" == "${l[1]}_enabled") || ("enable_${l[1]}" == "${l[0]}_enabled")] }
  if anytrue([for l in try(v.renamed == null ? [] : v.renamed, []) : ("enable_${l[0]}" == "${l[1]}_enabled") || ("enable_${l[1]}" == "${l[0]}_enabled")]) }
  flatten_enable_to_enabled = flatten([for k, v in local.enable_to_enabled : flatten([for i in v.renamed : {
    resource_type = k
    from          = i[0]
    to            = i[1]
  }])])
  enable_to_enabled_blocks = toset(flatten([
    for k, v in local.all_resources : [
      for obj in local.flatten_enable_to_enabled : {
        block_address = k
        mptf          = v.mptf
        from          = obj.from
        to            = obj.to
      } if v.mptf.block_labels[0] == obj.resource_type
    ]
  ]))
}


transform rename_block_element enable_to_enabled {
  dynamic "rename" {
    for_each = toset(local.enable_to_enabled_blocks)
    content {
      resource_type  = rename.value.mptf.block_labels[0]
      attribute_path = [rename.value.from]
      new_name       = rename.value.to
    }
  }
}

transform regex_replace_expression enable_to_enabled {
  for_each    = toset(local.enable_to_enabled_blocks)
  regex       = "${each.value.mptf.block_labels[0]}\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${each.value.from}"
  replacement = "${each.value.mptf.block_labels[0]}.$${1}$${2}$${3}$${4}$${5}${each.value.to}"
  depends_on  = [transform.rename_block_element.enable_to_enabled]
}
