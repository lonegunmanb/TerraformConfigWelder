locals {
  oc_removed_arguments = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if try(local.diffs[resource_type].oc_removed != null, false)])
  oc_removed_mptfs     = flatten([for _, blocks in local.oc_removed_arguments : [for b in blocks : b.mptf]])
  oc_removed_addresses = [for mptf in local.oc_removed_mptfs : mptf.block_address]
}

transform "update_in_place" oc_removed {
  for_each             = var.oc_removed_toggle ? try(local.oc_removed_addresses, []) : []
  target_block_address = each.value
  asstring {
    lifecycle {
      ignore_changes = <<-IGNORE
    %{if try(local.all_resources[each.value].lifecycle[0].ignore_changes != "", false)} [${trimsuffix(trimprefix(local.all_resources[each.value].lifecycle[0].ignore_changes, "["), "]")}, ${join(" ,", local.diffs[split(".", local.all_resources[each.value].mptf.terraform_address)[0]].oc_removed)}]
    %{else} [${join(" ,", local.diffs[local.all_resources[each.value].mptf.block_labels[0]].oc_removed)}]
    %{endif}
IGNORE
    }
  }
}