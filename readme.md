# TerraformBreakingChangeHelper

TBCH is an experimental tool designed to assist Terraform users in managing major version upgrades for a given Terraform provider. These upgrades often introduce breaking changes that require significant modifications to Terraform configurations. While providers may include schema migration mechanisms to handle Terraform State, Pusu helps by modifying the Terraform configuration files directly, following the upgrade guide.

## Overview

TBCH leverages [Mapotf](https://github.com/Azure/mapotf) configuration files written in HCL (HashiCorp Configuration Language) to define upgrade guides. These guides are interpreted and executed by the Mapotf engine to perform various tasks such as:

- Removing deprecated attributes and nested blocks.
- Renaming attributes and nested blocks.
- Updating all references to renamed properties in expressions.

## Known Limitations

1. **HCL Only**: Pusu currently supports only HCL files. JSON files are not supported at this time.
2. **Nested Block Renaming**: Pusu cannot use a renamed nested block name to match elements. For example, if you rename `foo` to `bar`, you cannot match `name` under the original `foo` block using `bar.name`.

## Install Mapotf

You can install mapotf by the following command(Assuming you have installed Golang >= 1.22.0):

```shell
go install github.com/Azure/mapoft@latest
```

We've also provided a devcontainer so you're welcomed to try Pusu in GitHub CodeSpace.

## How to

* AzureRM
  - [v3 to v4](azurerm/v3_v4/readme.md)
