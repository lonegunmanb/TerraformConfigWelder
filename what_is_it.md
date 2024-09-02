# Terraform Config Welder Explanation (Using AzureRM `v3` to `v4` Upgrade as an Example)

In StarCraft, there is an interesting setting where the Terran SVC has a multifunctional welding gun that can be used for mining, building various structures, repairing various buildings and mechanical units, and even attacking enemies. Thinking about it, such a welding gun is too sci-fi, it can almost do everything in StarCraft.

I have been working on this tool for a long time, which I call the Terraform Config Welder. It is a tool developed based on the [`mapotf`](https://github.com/Azure/mapotf) to mitigate the large number of breaking changes caused by the major version update of Terraform Provider.

The working mechanism of Terraform is that each service provider encapsulates their APIs as Terraform Providers, defining a series of resources and data sources in each Provider. Then users can declare these resources and data sources in Terraform config, which could be written in `hcl`(HashiCorp Configuration Language) or `json`. Terraform will generate an execution plan based on these declarations, execute this plan, and finally keep the state of cloud resources consistent with the state declared in the code.

Each resource will have a schema, which defines various properties of the resource, somewhat similar to the table structure of a database, but more complex, such as read-only fields, nested blocks, etc. When the major version of Terraform Provider is updated, this schema will change. If there's resource's declaration in user's config files, the change in the schema of this resource will break the user's config. For example, we can see many similar declarations in [Azure Resource Manager: 4.0 Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide):

* `azurerm_analysis_services_server`
  - The deprecated `enable_power_bi_service` property has been removed in favour of the power_bi_service_enabled property.

This change declaration tells us that the `enable_power_bi_service` attribute of the `azurerm_analysis_services_server` resource has been removed and replaced by the `power_bi_service_enabled` attribute. Suppose we have such a piece of V3 version Terraform code:

```go
resource "azurerm_analysis_services_server" "server" {
  location                = azurerm_resource_group.example.location
  name                    = "analysisservicesserver"
  resource_group_name     = azurerm_resource_group.example.name
  sku                     = "S0"
  admin_users             = ["myuser@domain.tld"]
  enable_power_bi_service = true
  tags = {
    abc = 123
  }

  ipv4_firewall_rule {
    name        = "myRule1"
    range_end   = "210.117.252.255"
    range_start = "210.117.252.0"
  }
}

locals {
  azurerm_analysis_services_server_enable_power_bi_service = azurerm_analysis_services_server.server.enable_power_bi_service
}
```

Then in the V4 version of Terraform Provider, this config will not be valid because `enable_power_bi_service` has been removed. At this time, we need to modify this config, change `enable_power_bi_service` to `power_bi_service_enabled`. We not only need to change the `enable_power_bi_service` in the `resource` block, but we also need to change the `enable_power_bi_service` in the `locals` block to ensure that the code can be executed normally.

We expect the modified code to look like this:

```go
resource "azurerm_analysis_services_server" "server" {
  location                 = azurerm_resource_group.example.location
  name                     = "analysisservicesserver"
  resource_group_name      = azurerm_resource_group.example.name
  sku                      = "S0"
  admin_users              = ["myuser@domain.tld"]
  power_bi_service_enabled = true
  tags = {
    abc = 123
  }

  ipv4_firewall_rule {
    name        = "myRule1"
    range_end   = "210.117.252.255"
    range_start = "210.117.252.0"
  }
}

locals {
  azurerm_analysis_services_server_enable_power_bi_service = azurerm_analysis_services_server.server.power_bi_service_enabled
}
```

But such correction work is error-prone, tedious and cumbersome, especially when you have hundreds of resource blocks. At this time, the Terraform config welder comes in handy, it can help you automate this modification process. You only need to provide a rule file, tell the Terraform code welding gun that `enable_power_bi_service` has been removed and replaced by `power_bi_service_enabled`, and then the Terraform code welding gun will automatically help you modify all Terraform codes.

```go
transform rename_block_element simply_renamed {
  for_each = var.simply_renamed_toggle ? ["simply_renamed"] : []
  dynamic "rename" {
    for_each = local.simply_renamed
    content {
      resource_type               = rename.value.resource_type
      attribute_path              = split(".", rename.value.from)
      new_name                    = rename.value.to
      rename_only_new_name_absent = true
    }
  }
}

transform regex_replace_expression simply_renamed {
  for_each    = var.simply_renamed_toggle ? [for rename in local.rename_with_replacement : rename] : []
  regex       = each.value.regex
  replacement = each.value.replacement
}
```

We declare two transformation blocks of Mapotf. `rename_block_element` can rename the element defined by `attribute_path`. This element can be an Attribute or a Nested Block.

`regex_replace_expression` will traverse all attribute value expressions in all Terraform code blocks in the directory and perform regular expression replacement on them. The value of `regex` probably looks like this: `(^|[^d]$|[^a]d$|[^t]da$|[^a]dat$|[^.]data$)${item_with_regex.resource_type}\\.(\\s*\\r?\\n\\s*)?(\\w+)(\\[\\s*[^]]+\\s*\\])?(\\.)(\\s*\\r?\\n\\s*)?${item_with_regex.regex}`, the value of `replacement` probably looks like this: `${item_with_replacement.resource_type}.$${1}$${2}$${3}$${4}$${5}${join("", item_with_replacement.replacement)}${item_with_replacement.to}`, this regular expression can match and replace the renamed attribute in the expression, and will exclude references to Data Source like `data.xxx`.

The above is the simplest example, let's look at a slightly more complicated example:

* `azurerm_key_vault_managed_hardware_security_module_role_assignment`
  - The deprecated `vault_base_url` property has been removed in favour of the `managed_hsm_id` property.

The HSM resource corresponding to `azurerm_key_vault_managed_hardware_security_module_role_assignment` originally looked like this for `vault_base_url`:

`https://{hsm-name}.managedhsm.azure.net/`

The corresponding `managed_hsm_id` probably looks like this:

`/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.KeyVault/managedHSMs/hsm1`

It won't be very easy to map the url to id. We can use such a Data Source to help us:

```go
data "azurerm_resources" "all_key_vault_hsm_azurerm" {
  provider = azurerm

  type = "Microsoft.KeyVault/managedHSMs"
}
```

This Data Source will return all HSM resources, and we can match the corresponding `managed_hsm_id` through `vault_base_url`. For example, the code before the transformation:

```go
resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_count" {
  count = 1

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  vault_base_url     = count.index == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : ""
}
```

Note that `vault_base_url` is a conditional expression, let's see what it looks like after the transformation:

```go
resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "with_count" {
  count = 1

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  managed_hsm_id     = one([for block in data.all_key_vault_hsm_azurerm.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (count.index == 1 ? var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url : "")]).id

  lifecycle {
    ignore_changes = [managed_hsm_id]
  }
}
```

We use the original value corresponding to `vault_base_url` to match the `vault_base_url` in `data.all_key_vault_hsm_azurerm`, and then read the corresponding `managed_hsm_id`. The transformation is accomplished in this way.

We also need to consider the situation where multiple provider instances may be used in the user's code, for example

```go
resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "this" {
  provider = azurerm.alternate

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  vault_base_url     = var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url
}
```

For this kind of block, we need to generate the corresponding Data Source block:

```go
data "azurerm_resources" "all_key_vault_hsm_azurerm_alternate" {
  provider = azurerm.alternate

  type = "Microsoft.KeyVault/managedHSMs"
}
```

Then the transformed `resource` block will look like this:

```go
resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "this" {
  provider = azurerm.alternate

  name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
  principal_id       = data.azurerm_client_config.current.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.resource_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.user.scope
  managed_hsm_id     = one([for block in data.all_key_vault_hsm_azurerm_alternate.resources : block.id if "https://${block.name}.managedhsm.azure.net/" == (var.key_vault_managed_hardware_security_module_role_assignment_vault_base_url)]).id

  lifecycle {
    ignore_changes = [managed_hsm_id]
  }
}
```

Note that both `provider` and the name of the Data Source used have changed.

* `azurerm_managed_application`
  - The deprecated `parameters` property has been removed in favour of the `parameter_values` property.

The original `parameters` type was a `map(string)`, and the new `parameter_values` type is `string`. The conversion rule can be written as:

`jsonencode({ for k, v in block.parameters : k => { value = v } })`

Before transformation:

```go
resource "azurerm_managed_application" "example" {
  kind                        = "ServiceCatalog"
  location                    = azurerm_resource_group.example.location
  managed_resource_group_name = "infrastructureGroup"
  name                        = "example-managedapplication"
  resource_group_name         = azurerm_resource_group.example.name
  application_definition_id   = azurerm_managed_application_definition.example.id
  parameters = {
    location                 = "eastus"
    storageAccountNamePrefix = "storeNamePrefix"
    storageAccountType       = "Standard_LRS"
  }
}

locals {
  azurerm_managed_application_parameters_location = azurerm_managed_application.example.parameters["location"]
}
```

After transformation:

```go
resource "azurerm_managed_application" "example" {
  kind                        = "ServiceCatalog"
  location                    = azurerm_resource_group.example.location
  managed_resource_group_name = "infrastructureGroup"
  name                        = "example-managedapplication"
  resource_group_name         = azurerm_resource_group.example.name
  application_definition_id   = azurerm_managed_application_definition.example.id
  parameter_values = jsonencode({ for k, v in {
    location                 = "eastus"
    storageAccountNamePrefix = "storeNamePrefix"
    storageAccountType       = "Standard_LRS"
  } : k => { value = v } })
}

locals {
  azurerm_managed_application_parameters_location = ({ for k, v in jsondecode(azurerm_managed_application.example.parameter_values) : k => v.value })["location"]
}
```

You must not only transform the `parameters` in the `resource` block into a new json string, but also ensure that all expressions referring to `parameters` are replaced with references to `parameter_values`, and convert back to the original `map(string)` type. Very interesting.

Let's look at a more complex example:

* `azurerm_managed_disk`
  - The deprecated `encryption_settings.enabled` property has been removed, enabling and disabling encryption is controlled by the presence or absence of the `encryption_settings` block.

Previously, there was an `enabled` boolean attribute in the `encryption_settings` nested block. Now this attribute has been removed, and instead, the presence or absence of the `encryption_settings` nested block controls the encryption switch. The difficulty here is that regardless of whether the original `encryption_settings` is `dynamic`, we have to convert it to `dynamic`, because only in this the only way we can control whether to turn on encryption based on the presence or absence of the block.

From here, we can divide the situation into 4 types:

1. Static `encryption_settings` block, without `enabled` attribute
2. Static `encryption_settings` block, with `enabled` attribute
3. Dynamic `encryption_settings` block, without `enabled` attribute
4. Dynamic `encryption_settings` block, with `enabled` attribute

For the original situation without the `enabled` attribute, we don't need to transform it, because the default value of `enabled` is `true`, so the existence of this block itself already meets its semantics. For the original situation with the `enabled` attribute, we need to ensure that the block after conversion is `dynamic` and also inject the value of the `enabled` expression into the `for_each` of the `dynamic` block.

```go
resource "azurerm_managed_disk" "enabled" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  encryption_settings {
    enabled = true
  }
}
```

After transformation:

```go
resource "azurerm_managed_disk" "enabled" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynamic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}
```

Please note:

```go
dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings
```

Here, the value of `(true)` in `for_each` comes from the original nested block:

```go
encryption_settings {
    enabled = true
```

Because the original nested block was a static one, the iteration set generated by `for_each` is also a simple static `["encryption_settings"]`.

For the original situation that is a `dynamic` block:

```go
resource "azurerm_managed_disk" "dynamic_encryption_settings" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = ["encryption_settings"]

    content {
      enabled = true

      key_encryption_key {
        key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
        source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
      }
    }
  }
}
```

After transformation:

```go
resource "azurerm_managed_disk" "dynamic_encryption_settings" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = try((true) ? { for k, v in(["encryption_settings"]) : k => v } : tomap({}), (true) ? (["encryption_settings"]) : toset([]))
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynamic "key_encryption_key" {
        for_each = ["key_encryption_key"]
        iterator = key_encryption_key

        content {
          key_url         = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_key_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_key_encryption_key_source_vault_id
        }
      }
    }
  }
}
```

Attentive readers will find that the `for_each` expression after transformation is unexpectedly complex:

`for_each = try((true) ? { for k, v in(["encryption_settings"]) : k => v } : tomap({}), (true) ? (["encryption_settings"]) : toset([]))`

This is because we don't know the type of the `for_each` iteration set in the user code when we write the transformation rules. There are three types of collections available for iteration in Terraform: `list`, `map`, and `set`. The iterators of these three collections all provide `key` and `value`, and `key` and `value` are variables that can be used inside the dynamic nested block. For the three collections, `value` corresponds to the element itself, but `key` will be different. For `list`, `key` is the element number; for `map`, `key` is the `string` type key; for `set`, `key` is the element itself. Because we need to decide the iteration set based on the value of the original `enabled` expression, how to dynamically construct a set so that its `key` and `value` can be consistent with the transformation before, this becomes a challenge. Our expression actually used the `try` function to solve this problem.

The first expression of the `try` function constructs a `map` based on the value of `enabled`. When `enabled` is `true`, this `map`'s expression is `{ for k, v in(["encryption_settings"]) : k => v }`. It should be understood that when we write transformation rules, we don't know what type the expression `["encryption_settings"]` written by the user corresponds to. Here we discuss separately:

* If it is a `list`, then the user expects `key` to be a `number`, corresponding to the element number, and `value` is the element itself. The `key` of the converted `map` is a `string`, corresponding to the string form of the element number; `value` is the element itself. Terraform has the ability to implicitly type convert, so `"1"` can be used directly as `1`, and there is no difference between the converted `map` and the original `list`.
* If it is a `map`, then we just use the `for` expression to redeclare it, and there is no difference in use.
* If it is a `set(string)`, then the user expects `key` and `value` to be the element itself, and the `key` and `value` of the converted `map(string)` are the element itself, and there is no difference in use.

The only challenge situation is the `set` with non-`string` elements, for example, a `set(object)`, at this time `{ for k, v in(<YOUR set(object)>) : k => v }` will trigger a runtime error, because the `map` in Terraform The key must be a `string` or a type that can be implicitly converted to `string`. But because we used the `try` function, this error will cause `try` to try to evaluate and return the second parameter:

`(true) ? (<YOUR set(object)>) : toset([])`

At this time, the return is the original `set` or an empty `set`. Through such a strange transformation, we can cope with various collection types used in user code.

Mapotf currently does not support direct modification of the `dynamic` block, so our approach is to delete the original `encryption_settings` block and then add a corresponding new `dynamic "encryption_settings"` block calculated by us back. In addition, the `update_in_place` of Mapotf can currently only set values for Attributes, and cannot directly set code for a certain nested block as a whole, so we must construct the entire `encryption_settings` block completely.

There are two nested blocks in `encryption_settings`: `disk_encryption_key` and `key_encryption_key`. Because we must construct the `encryption_settings` block completely, whether or not these two nested blocks were originally, our new `encryption_settings` must contain them.

For the original situation without any nested block, we can construct an empty `dynamic` block, for example, before transformation:

```go
resource "azurerm_managed_disk" "enabled" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  encryption_settings {
    enabled = true
  }
}
```

After transformation:

```go
resource "azurerm_managed_disk" "enabled" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = []
        iterator = disk_encryption_key

        content {
          secret_url      = null
          source_vault_id = null
        }
      }
      dynamic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}
```

As you can see, the set of `for_each` is empty, and all the values in `content` are `null`. This nested block is declared, but it is the same as not declared. Static nested blocks will also be converted to dynamic nested blocks, for example:

```go
resource "azurerm_managed_disk" "disk_encryption_key" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  encryption_settings {
    enabled = true

    disk_encryption_key {
      secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
      source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
    }
  }
}
```

After transformation:

```go
resource "azurerm_managed_disk" "disk_encryption_key" {
  create_option        = "Empty"
  location             = azurerm_resource_group.example.location
  name                 = "enabled"
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = "1"
  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = (true) ? ["encryption_settings"] : []
    iterator = encryption_settings

    content {
      dynamic "disk_encryption_key" {
        for_each = ["disk_encryption_key"]
        iterator = disk_encryption_key

        content {
          secret_url      = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_secret_url
          source_vault_id = var.azurerm_managed_disk_disk_encryption_key_encryption_settings_disk_encryption_key_source_vault_id
        }
      }
      dynamic "key_encryption_key" {
        for_each = []
        iterator = key_encryption_key

        content {
          key_url         = null
          source_vault_id = null
        }
      }
    }
  }
}
```

`encryption_settings.disk_encryption_key` has been converted into an equivalent dynamic nested block.

There are some more complex transformation examples that are not detailed here. [TerraformConfigWelder](https://github.com/lonegunmanb/TerraformConfigWelder) is open source under the MIT license. If you are interested, you can currently try the following command to upgrade the Terraform AzureRM Provider code from `v3` to `v4`:

```bash
mapotf transform --tf-dir <your_tf_dir> --mptf-dir git::https://github.com/lonegunmanb/TerraformConfigWelder.git//azurerm/v3_v4
```

Readers can install Mapotf with the following command:

```bash
go install github.com/Azure/mapotf@latest
```

You can use the following command to undo the transformation:

```bash
mapotf reset --tf-dir <your_tf_dir>
```

This project currently only supports the upgrade from `v3` to `v4` of the AzureRM Provider, but in fact, we can write transformation rules for any version upgrade of any Provider. I hope everyone will like this project.