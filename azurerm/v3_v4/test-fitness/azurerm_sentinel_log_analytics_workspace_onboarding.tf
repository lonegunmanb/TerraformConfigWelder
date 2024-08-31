resource "azurerm_sentinel_log_analytics_workspace_onboarding" "singleton" {
  provider = alternative

  customer_managed_key_enabled = false
  resource_group_name          = var.azurerm_sentinel_log_analytics_workspace_onboarding_resource_group_name
  workspace_name               = var.azurerm_sentinel_log_analytics_workspace_onboarding_workspace_name
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "count" {
  count = var.azurerm_sentinel_log_analytics_workspace_onboarding_count

  customer_managed_key_enabled = false
  resource_group_name          = local.azurerm_sentinel_log_analytics_workspace_onboarding_count_rg_names[count.index]
  workspace_name               = local.azurerm_sentinel_log_analytics_workspace_onboarding_count_names[count.index]
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "for_each" {
  for_each = var.azurerm_sentinel_log_analytics_workspace_onboarding_for_each

  customer_managed_key_enabled = false
  resource_group_name          = each.value
  workspace_name               = each.value
}

locals {
  azurerm_sentinel_log_analytics_workspace_onboarding_count_workspace_name         = azurerm_sentinel_log_analytics_workspace_onboarding.count[0].workspace_name
  azurerm_sentinel_log_analytics_workspace_onboarding_for_each_resource_group_name = azurerm_sentinel_log_analytics_workspace_onboarding.for_each["a"].resource_group_name
}