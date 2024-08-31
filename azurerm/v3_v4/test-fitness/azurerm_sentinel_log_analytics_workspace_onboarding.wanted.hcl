resource "azurerm_sentinel_log_analytics_workspace_onboarding" "singleton" {
  provider = alternative

  customer_managed_key_enabled = false
  workspace_id                 = data.azurerm_log_analytics_workspace.azurerm_sentinel_log_analytics_workspace_onboarding_singleton.workspace_id
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "count" {
  count = var.azurerm_sentinel_log_analytics_workspace_onboarding_count

  customer_managed_key_enabled = false
  workspace_id                 = data.azurerm_log_analytics_workspace.azurerm_sentinel_log_analytics_workspace_onboarding_count[count.index].workspace_id
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "for_each" {
  for_each = var.azurerm_sentinel_log_analytics_workspace_onboarding_for_each

  customer_managed_key_enabled = false
  workspace_id                 = data.azurerm_log_analytics_workspace.azurerm_sentinel_log_analytics_workspace_onboarding_for_each[each.key].workspace_id
}

locals {
  azurerm_sentinel_log_analytics_workspace_onboarding_count_workspace_name         = data.azurerm_log_analytics_workspace.azurerm_sentinel_log_analytics_workspace_onboarding_count[0].name
  azurerm_sentinel_log_analytics_workspace_onboarding_for_each_resource_group_name = data.azurerm_log_analytics_workspace.azurerm_sentinel_log_analytics_workspace_onboarding_for_each["a"].resource_group_name
}
data "azurerm_log_analytics_workspace" "azurerm_sentinel_log_analytics_workspace_onboarding_singleton" {
  provider = alternative

  name                = var.azurerm_sentinel_log_analytics_workspace_onboarding_workspace_name
  resource_group_name = var.azurerm_sentinel_log_analytics_workspace_onboarding_resource_group_name
}

data "azurerm_log_analytics_workspace" "azurerm_sentinel_log_analytics_workspace_onboarding_count" {
  provider = azurerm
  count    = var.azurerm_sentinel_log_analytics_workspace_onboarding_count

  name                = local.azurerm_sentinel_log_analytics_workspace_onboarding_count_names[count.index]
  resource_group_name = local.azurerm_sentinel_log_analytics_workspace_onboarding_count_rg_names[count.index]
}

data "azurerm_log_analytics_workspace" "azurerm_sentinel_log_analytics_workspace_onboarding_for_each" {
  provider = azurerm
  for_each = var.azurerm_sentinel_log_analytics_workspace_onboarding_for_each

  name                = each.value
  resource_group_name = each.value
}

