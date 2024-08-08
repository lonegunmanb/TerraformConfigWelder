# Config Migration From V3 to V4

We've provided a set of demo Terraform `azurerm` resource blocks to demonstrate how to migrate from v3 to v4.

Execute the following command to run the migration:

```shell
mapotf init
mapotf transform -r --mptf-dir . --tf-dir .
```

`mapotf init` is actually `terraform init` under the hood, and `mapotf transform` is the command to start the transformation process. `-r` means recursive mode, which would transform content inside `sub_module` too. And `--mptf-dir` and `--tf-dir` are the directories where the Mapotf configuration files and Terraform configuration files are located, respectively.

You can try yourself and then compare the changes in the Terraform configuration files.

Finally, you can always revert changes made by Mapotf by `reset` command: 

```Shell
mapotf reset
```