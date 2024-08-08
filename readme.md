# Pusu: Patterned Upgrade Supportive Utility

Pusu is an experimental tool designed to assist Terraform users in managing major version upgrades for a given Terraform provider. These upgrades often introduce breaking changes that require significant modifications to Terraform configurations. While providers may include schema migration mechanisms to handle Terraform State, Pusu helps by modifying the Terraform configuration files directly, following the upgrade guide.

## Overview

Pusu leverages [Mapotf](https://github.com/Azure/mapotf) configuration files written in HCL (HashiCorp Configuration Language) to define upgrade guides. These guides are interpreted and executed by the Mapotf engine to perform various tasks such as:

- Removing deprecated attributes and nested blocks.
- Renaming attributes and nested blocks.
- Updating all references to renamed properties in expressions.

## Features

- **Automated Configuration Updates**: Pusu automates the process of updating Terraform configurations based on the upgrade guide, reducing the manual effort required.
- **Schema Migration**: It handles schema migrations by modifying the configuration files to align with the new schema.
- **Reference Updates**: Pusu ensures that all references to renamed properties are updated throughout the configuration.

## Known Limitations

1. **HCL Only**: Pusu currently supports only HCL files. JSON files are not supported at this time.
2. **Nested Block Renaming**: Pusu cannot use a renamed nested block name to match elements. For example, if you rename `foo` to `bar`, you cannot match `name` under the original `foo` block using `bar.name`.

## Conclusion

Pusu is a powerful tool for managing Terraform provider upgrades, automating the process of updating configurations to comply with new schemas and reducing the burden on developers. By following the upgrade guides defined in Mapotf configuration files, Pusu ensures a smooth transition during major version upgrades.