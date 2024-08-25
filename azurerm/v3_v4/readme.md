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
mapotf transform -r --mptf-dir . --tf-dir .
```

`mapotf transform` is the command to start the transformation process. `--mptf-dir` and `--tf-dir` are the directories where the Mapotf configuration files and Terraform configuration files are located, respectively.

You can try yourself and then compare the changes in the Terraform configuration files.

Finally, you can always revert changes made by Mapotf by `reset` command: 

```Shell
mapotf reset
```

If you'd like to run these tranforms against your own Terraform configuration files, you can use the following command:

```shell
mapotf transform --tf-dir <your_terraform_config_folder> --mptf-dir git::https://github.com/lonegunmanb/TerraformConfigWelder.git//azurerm/v3_v4
```

## Unsupported Transforms

All new default values introduced by `v4` won't be transformed.

The following transforms are not supported in this version:

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