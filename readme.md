# TerraformConfigWelder

TerraformConfigWelder is an experimental tool designed to assist Terraform users in managing major version upgrades for a given Terraform provider. These upgrades often introduce breaking changes that require significant modifications to Terraform configurations. While providers may include schema migration mechanisms to handle Terraform State, TerraformConfigWelder helps by modifying the Terraform configuration files directly, following the upgrade guide.

This solution is still an experimental tool and may not cover all possible upgrade scenarios. You **MUST** review the changes made by TerraformConfigWelder and test them in a non-production environment before applying them to your production environment.

## Overview

TerraformConfigWelder leverages [Mapotf](https://github.com/Azure/mapotf) configuration files written in HCL (HashiCorp Configuration Language) to define upgrade guides. These guides are interpreted and executed by the Mapotf engine to perform various tasks such as:

- Removing deprecated attributes and nested blocks.
- Renaming attributes and nested blocks.
- Updating all references to renamed properties in expressions.

## Known Limitations

TerraformConfigWelder is not tendered for 100% coverage of all possible upgrade scenarios. The following limitations are known:

1. **HCL Only**: Mapotf currently supports only HCL files. JSON files are not supported at this time.
2. **Nested Block Renaming**: TerraformConfigWelder cannot use a renamed nested block name to match elements. For example, if you rename `foo` to `bar`, you cannot match `name` under the original `foo` block using `bar.name`.

Other limitations may exist, please read readme files in each provider's folder for more details.

## Install Mapotf

You can install mapotf by the following command(Assuming you have installed Golang >= 1.22.0):

```shell
go install github.com/Azure/mapoft@latest
```

We've also provided a devcontainer so you're welcomed to try TerraformConfigWelder in GitHub CodeSpace.

## Index

* AzureRM
  - [v3 to v4](azurerm/v3_v4/readme.md)
