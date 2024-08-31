/*
        var enforceOk bool
		var enforceServiceOk bool
		var enableOk bool
		var enableServiceOk bool
		var privateEndpointNetworkPoliciesOk bool
		var enforcePrivateEndpointNetworkPoliciesRaw bool
		var enforcePrivateLinkServiceNetworkPoliciesRaw bool
		var privateEndpointNetworkPoliciesRaw bool
		var privateLinkServiceNetworkPoliciesRaw bool
		var privateEndpointNetworkPoliciesStringRaw string

		// Set the legacy default value since they are now computed optional
		privateEndpointNetworkPolicies = subnets.VirtualNetworkPrivateEndpointNetworkPoliciesEnabled
		privateLinkServiceNetworkPolicies = subnets.VirtualNetworkPrivateLinkServiceNetworkPoliciesEnabled

		// This is the only way I was able to figure out if the fields are actually in the config or not,
		// which is needed here because these are all now optional computed fields...
		if !pluginsdk.IsExplicitlyNullInConfig(d, "enforce_private_link_endpoint_network_policies") {
			enforceOk = true
			enforcePrivateEndpointNetworkPoliciesRaw = d.Get("enforce_private_link_endpoint_network_policies").(bool)
		}

		if !pluginsdk.IsExplicitlyNullInConfig(d, "enforce_private_link_service_network_policies") {
			enforceServiceOk = true
			enforcePrivateLinkServiceNetworkPoliciesRaw = d.Get("enforce_private_link_service_network_policies").(bool)
		}

		if !pluginsdk.IsExplicitlyNullInConfig(d, "private_endpoint_network_policies_enabled") {
			enableOk = true
			privateEndpointNetworkPoliciesRaw = d.Get("private_endpoint_network_policies_enabled").(bool)
		}

		if !pluginsdk.IsExplicitlyNullInConfig(d, "private_link_service_network_policies_enabled") {
			enableServiceOk = true
			privateLinkServiceNetworkPoliciesRaw = d.Get("private_link_service_network_policies_enabled").(bool)
		}

		if !pluginsdk.IsExplicitlyNullInConfig(d, "private_endpoint_network_policies") {
			privateEndpointNetworkPoliciesOk = true
			privateEndpointNetworkPoliciesStringRaw = d.Get("private_endpoint_network_policies").(string)
		}

		// Only one of these values can be set since they conflict with each other
		// if neither of them are set use the default values
		if enforceOk || enableOk || privateEndpointNetworkPoliciesOk {
			switch {
			case enforceOk:
				privateEndpointNetworkPolicies = subnets.VirtualNetworkPrivateEndpointNetworkPolicies(expandEnforceSubnetNetworkPolicy(enforcePrivateEndpointNetworkPoliciesRaw))
			case enableOk:
				privateEndpointNetworkPolicies = subnets.VirtualNetworkPrivateEndpointNetworkPolicies(expandSubnetNetworkPolicy(privateEndpointNetworkPoliciesRaw))
			case privateEndpointNetworkPoliciesOk:
				privateEndpointNetworkPolicies = subnets.VirtualNetworkPrivateEndpointNetworkPolicies(privateEndpointNetworkPoliciesStringRaw)
			}
		}

		if enforceServiceOk || enableServiceOk {
			if enforceServiceOk {
				privateLinkServiceNetworkPolicies = subnets.VirtualNetworkPrivateLinkServiceNetworkPolicies(expandEnforceSubnetNetworkPolicy(enforcePrivateLinkServiceNetworkPoliciesRaw))
			} else if enableServiceOk {
				privateLinkServiceNetworkPolicies = subnets.VirtualNetworkPrivateLinkServiceNetworkPolicies(expandSubnetNetworkPolicy(privateLinkServiceNetworkPoliciesRaw))
			}
		}
 */
resource "azurerm_subnet" "example" {
  address_prefixes                               = ["10.0.1.0/24"]
  name                                           = "example-subnet"
  resource_group_name                            = azurerm_resource_group.example.name
  virtual_network_name                           = azurerm_virtual_network.example.name
  enforce_private_link_endpoint_network_policies = var.azurerm_subnet_enforce_private_link_endpoint_network_policies
  enforce_private_link_service_network_policies  = var.azurerm_subnet_enforce_private_link_service_network_policies
  private_endpoint_network_policies_enabled      = var.azurerm_subnet_private_endpoint_network_policies_enabled

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}