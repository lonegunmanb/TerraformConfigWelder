resource "azurerm_cdn_endpoint_custom_domain" "example" {
  cdn_endpoint_id = azurerm_cdn_endpoint.example.id
  host_name       = "${azurerm_dns_cname_record.example.name}.${data.azurerm_dns_zone.example.name}"
  name            = "example-domain"

  user_managed_https {
    key_vault_secret_id = var.azurerm_cdn_endpoint_custom_domain.user_managed_https.key_vault_certificate_id
  }

  lifecycle {
    ignore_changes = [user_managed_https[0].key_vault_secret_id]
  }
}

locals {
  azurerm_cdn_endpoint_custom_domain_user_managed_https_key_vault_certificate_id = azurerm_cdn_endpoint_custom_domain.example.user_managed_https[0].key_vault_secret_id
}