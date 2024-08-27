# Config Migration From V3 to V4

This folder contains a set of [Mapotf](https://github.com/Azure/mapotf) configuration files to migrate your Terraform configs from `azurerm` provider version `v3` to `v4`.

You can install `mapotf` by running the following command:

```shell
go install github.com/Azure/mapotf@latest
```

## WARNING!!!

`mapotf` is an experimental tool and the migration may not be perfect. Please review the changes made by `mapotf` before applying them to your Terraform configuration files.

All transformed Terraform files would have corresponding `.mptfbackup` or `.mptfnew` files. `.mptfbackup` file is the original Terraform file before the transformation, and `.mptfnew` file is an indicator that shows the corresponding Terraform file was created by `mapotf`. You can compare the changes between the original and transformed Terraform files.

You can always revert all changes made by `mapotf` by: `mapotf reset`. Once you're satisfied with the changes, you can clean all backup files by running `mapotf clean-backup`.

Before you accept changes made by `mapotf`, you MUST run `terraform plan` and review the changes carefully to avoid any potential issues.

Remember, not all breaking changes introduced by `v4` can be automatically transformed by `mapotf`. You may need to manually update your Terraform configuration files.

## How to Use

We've provided a set of demo Terraform `azurerm` resource blocks to demonstrate how to migrate from v3 to v4.

Execute the following command to run the migration:

```shell
mapotf transform -r --mptf-dir git::https://github.com/lonegunmanb/TerraformConfigWelder.git//azurerm/v3_v4 --tf-dir test-fitness
```

`mapotf transform` is the command to start the transformation process. `--mptf-dir` and `--tf-dir` are the directories where the Mapotf configuration files and Terraform configuration files are located, respectively.

`test-fitness` is a folder contains examples of Terraform configuration files that use `azurerm` provider version `v3`. The expected output is stored as `xxx.wanted.hcl`. If you run the transforms we provided then `avmfix -folder test-fitness`, the Terraform configs would be transformed exactly as the `xxx.wanted.hcl` files. You can install `avmfix` by running `go install github.com/lonegunmanb/avmfix@latest`.

You can try yourself and then compare the changes in the Terraform configuration files.

Finally, you can always revert changes made by Mapotf by `reset` command: 

```Shell
mapotf reset --tf-dir test-fitness
```

If you'd like to run these transforms against your own Terraform configuration files, you can use the following command:

```shell
mapotf transform --tf-dir <your_terraform_config_folder> --mptf-dir git::https://github.com/lonegunmanb/TerraformConfigWelder.git//azurerm/v3_v4
```

To revert changes:

```shell
mapotf reset --tf-dir <your_terraform_config_folder>
```

## Transform categories

These transforms are categorized into the following groups:

* Attributes renamed from `enable_xxx` to `xxx_enabled`, defined in [`enable_to_enabled.mptf.hcl`](enable_to_enabled.mptf.hcl).
* Simply renamed attributes and nested blocks, defined in [`simply_renamed.mptf.hcl`](simply_renamed.mptf.hcl).
* Removed deprecated attributes and nested blocks, defined in [`attribute_removed.mptf.hcl`](attribute_removed.mptf.hcl).
* Attributes that are no longer Computed, you might need to add them into `ignore_changes` list, defined in [`oc_removed.mptf.hcl`](oc_removed.mptf.hcl). (OC stands for Optional-Computed)
* Special transforms to specified resources, defined in `azurerm_xxx_mptf.hcl` files.

Not all breaking changes list in [4.0-upgrade-guide](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azure-provider-version-v40) could be transformed by `mapotf`. Please read [Unsupported Transforms](#Unsupported-Transforms) for more details.

## Transform toggles

You would see multiple `azurerm_xxx_toggle` variables in `variable.mptf.hcl` file. These variables are used to control the transformation process. You can set them to `true` or `false` to enable or disable the corresponding transform. For example:

```hcl
mapotf transform --tf-dir . --mptf-dir git::https://github.com/lonegunmanb/TerraformConfigWelder.git//azurerm/v3_v4 --mptf-var azurerm_linux_web_app_toggle=false
```

This would disable the transformation for `azurerm_linux_web_app` resource.

**Notes:** These resource toggles doesn't work for transforms that remove deprecated attributes and nested blocks. If you'd like to skip these removal transforms, you can set `var.attribute_removed_toggle` to `false`.

`var.oc_removed_toggle` controls the transforms that add attributes that removed `Computed` declaration to resource's `ignore_changes` list.

`var.oc_removed_bypass_types` allows you to bypass adding oc-removed attributes into `ignore_changes` list for specific types.

`var.simply_renamed_toggle` controls the transforms that rename attributes and nested blocks.

`var.enable_to_enabled_toggle` controls the transforms that rename attributes from `enable_xxx` to `xxx_enabled`.

`var.attribute_removed_toggle` controls the transforms that remove deprecated attributes and nested blocks.

## Unsupported Transforms

All removed resources, data sources won't be transformed.

All new default values introduced by `v4` won't be transformed.

All changes to attribute's default value won't be processed.

All new required properties introduced by `v4` won't be transformed.

All `xxx and yyy must be set together` rules won't be processed.

All `The deprecated block xxx has been removed in favour of the azurerm_yyy resource.` changes won't be processed.

The following breaking changes on managed resources are not processed in this version:

* `azurerm_automation_software_update_configuration`
  - The property `target.azure_query.tag_filter` is no longer Computed. If you experience a diff as a result of this change you may need to add this to ignore_changes.
* [`azurerm_image`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_image)
  - A new required property `storage_type` has been added to the `os_disk` and `data_disk` blocks.
* [`azurerm_monitor_action_group`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_monitor_action_group)
  - The deprecated property `event_hub_receiver.event_hub_id` has been removed in favour of the `event_hub_receiver.event_hub_name` and `event_hub_receiver.event_hub_namespace` properties.
* [`azurerm_monitor_diagnostic_categories`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_monitor_diagnostic_categories)
  - The deprecated property `logs` will be removed in favour of the `log_category_types` property.
* [`azurerm_monitor_diagnostic_setting`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_monitor_diagnostic_setting)
  - The deprecated `enabled_log.retention_policy` block has been removed in favour of the `azurerm_storage_management_policy` resource.
  - The deprecated `metric.retention_policy` block has been removed in favour of the `azurerm_storage_management_policy` resource.
* [`azurerm_nginx_deployment`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_nginx_deployment)
  - The deprecated block `configuration` has been removed in favour of the `azurerm_nginx_configuration` resource.
* [`azurerm_attestation_provider`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_attestation_provider)
  - The deprecated block policy has been removed in favour of the `open_enclave_policy_base64`, `sgx_enclave_policy_base64`, `tpm_policy_base64` and `sev_snp_policy_base64` properties.
* [`azurerm_site_recovery_replication_recovery_plan`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_site_recovery_replication_recovery_plan)
  - The deprecated block `recovery_group` has been removed in favour of the `shutdown_recovery_group`, `failover_recovery_group` and `boot_recovery_group` properties.
* [`azurerm_sentinel_automation_rule`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_sentinel_automation_rule)
  - The deprecated property `condition` has been removed in favour of the `condition_json` property.
* [`azurerm_virtual_network`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_virtual_network)
  - The property `address_space` has been changed from a list to a set. If you're referencing an element in this property then this will require code changes.
* [`azurerm_web_application_firewall_policy`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_web_application_firewall_policy)
  - The deprecated property `managed_rules.managed_rule_set.rule_group_override.disabled_rules` has been removed in favour of the `managed_rules.managed_rule_set.rule_group_override.rule` block.

The following breaking changes on data sources are not processed in this version:

* [`azurerm_monitor_action_group`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_monitor_action_group-1)
  - The deprecated property `event_hub_receiver.event_hub_id` has been removed in favour of the `event_hub_receiver.event_hub_name` and `event_hub_receiver.event_hub_namespace` properties.
* [`azurerm_storage_account_customer_managed_key`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_storage_account_customer_managed_key)
  - The property `key_vault_id` no longer accepts Managed HSM keys, instead please use the `managed_hsm_key_id` property.
* [`azurerm_storage_share_directory`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_storage_share_directory-1)
  - The deprecated properties `storage_account_name` and `share_name` have been removed in favour of the `storage_share_id` property.
* [`azurerm_storage_table_entity`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_storage_table_entity-1)
  - The deprecated properties `storage_account_name` and `table_name` have been removed in favour of the `storage_table_id` property.
* [`azurerm_storage_table_entities`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_storage_table_entities)
  - The deprecated properties `storage_account_name` and `table_name` have been removed in favour of the `storage_table_id` property.
* [`azurerm_subnet`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_subnet-1)
  - The deprecated property `private_endpoint_network_policies_enabled` has been removed in favour of the `private_endpoint_network_policies` property.
  - The deprecated property `enforce_private_link_endpoint_network_policies` has been removed in favour of the `private_endpoint_network_policies` property.
  - The deprecated property `enforce_private_link_service_network_policies` has been removed in favour of the `private_link_service_network_policies_enabled` property.
* [`azurerm_servicebus_namespace_authorization_rule`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_servicebus_namespace_authorization_rule)
  - The deprecated property `namespace_name` has been removed in favour of the `namespace_id` property.
  - The deprecated property `resource_group_name` has been removed in favour of the `namespace_id` property.
* [`azurerm_servicebus_namespace_disaster_recovery_config`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_servicebus_namespace_disaster_recovery_config)
  - The deprecated property `namespace_name` has been removed in favour of the `namespace_id` property.
  - The deprecated property `resource_group_name` has been removed in favour of the `namespace_id` property.
* [`azurerm_servicebus_queue`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_servicebus_queue-1)
  - The deprecated property `namespace_name` has been removed in favour of the `namespace_id` property.
  - The deprecated property `resource_group_name` has been removed in favour of the `namespace_id` property.
* [`azurerm_servicebus_subscription`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_servicebus_subscription-1)
  - The deprecated property `namespace_name` has been removed in favour of the `topic_id` property.
  - The deprecated property `resource_group_name` has been removed in favour of the `topic_id` property.
  - The deprecated property `topic_name` has been removed in favour of the `topic_id` property.
* [`azurerm_servicebus_topic`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_servicebus_topic-1)
  - The deprecated property `namespace_name` has been removed in favour of the `namespace_id` property.
  - The deprecated property `resource_group_name` has been removed in favour of the `namespace_id` property.
* [`azurerm_servicebus_namespace`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_servicebus_namespace-1)
  - The deprecated property `zone_redundant` has been removed.
* [`azurerm_windows_web_app`](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/guides/4.0-upgrade-guide#azurerm_windows_web_app-1)
  - The property `site_config.application_stack.docker_container_registry` has been removed.
  - The property `site_config.application_stack.docker_container_name` has been removed.
  - The property `site_config.application_stack.docker_container_tag` has been removed.