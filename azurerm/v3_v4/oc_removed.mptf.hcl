locals {
  extra_oc_removed = {
    azurerm_kubernetes_cluster = [
      "network_profile.load_balancer_profile.outbound_ip_prefix_ids",
      "network_profile.load_balancer_profile.outbound_ip_address_ids",
    ]
    azurerm_machine_learning_datastore_datalake_gen2 = [
      "authority_url",
    ]
    azurerm_network_interface = [
      "dns_servers",
    ]
    azurerm_signalr_service = [
      "cors",
    ]
  }
  oc_removed_bypass_list = {
    azurerm_automation_software_update_configuration = [
      "target.azure_query.tag_filter",
    ]
  }
  all_oc_removed_types                          = [for t in distinct(concat(keys({ for t, d in local.diffs : t => d if d.oc_removed != null }), keys(local.extra_oc_removed))) : t if !contains(var.oc_removed_bypass_types, t)]
  oc_removed_items                              = { for t in local.all_oc_removed_types : t => setsubtract(distinct(concat(try(local.diffs[t].oc_removed, []), try(local.extra_oc_removed[t], []))), try(local.oc_removed_bypass_list[t], [])) }
  oc_removed_items_with_processed_nested_blocks = { for t, items in local.oc_removed_items : t => [for i in items : strcontains(i, ".") ? (join("[0].", split(".", i))) : i] }
  oc_removed_arguments                          = flatten([for resource_type, resource_blocks in data.resource.all.result : resource_blocks if contains(local.all_oc_removed_types, resource_type)])
  oc_removed_mptfs                              = flatten([for _, blocks in local.oc_removed_arguments : [for b in blocks : b.mptf]])
  oc_removed_addresses                          = [for mptf in local.oc_removed_mptfs : mptf.block_address]
}

transform "update_in_place" oc_removed {
  for_each             = var.oc_removed_toggle ? try(local.oc_removed_addresses, []) : []
  target_block_address = each.value
  asstring {
    lifecycle {
      ignore_changes = <<-IGNORE
    %{if try(local.all_resources[each.value].lifecycle[0].ignore_changes != "", false)} [${trimsuffix(trimprefix(local.all_resources[each.value].lifecycle[0].ignore_changes, "["), "]")}, ${join(" ,", local.oc_removed_items_with_processed_nested_blocks[local.all_resources[each.value].mptf.block_labels[0]], [])}]
    %{else} [${join(" ,", local.oc_removed_items_with_processed_nested_blocks[local.all_resources[each.value].mptf.block_labels[0]], [])}]
    %{endif}
IGNORE
    }
  }
}