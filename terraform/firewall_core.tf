resource "azurerm_public_ip" "firewall-pip" {
  name                = "firewall-pip-${local.enviromentletter}-${local.regioncode}"
  location            = "${local.location}" 
  resource_group_name = "${local.resource_group_name}"
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label = "${var.firewalldomainname[local.enviromentletter]}"
}

resource "azurerm_firewall" "central-firewall" {
  name                = "central-firewall-${local.enviromentletter}-${local.regioncode}"
  location            = "${local.location}" 
  resource_group_name = "${local.resource_group_name}"
  sku_name            = "AZFW_VNet"
  sku_tier            = "${var.centralFirewall-sku}"
  firewall_policy_id = azurerm_firewall_policy.central-firewall-policy.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.firewall-pip.id
  }
  depends_on = [
    azurerm_log_analytics_workspace.firewall-log_analytics_workspace,
    azurerm_firewall_policy_rule_collection_group.firewall_rule_collection_application,
    azurerm_firewall_policy_rule_collection_group.firewall_rule_collection_nat,
    azurerm_firewall_policy_rule_collection_group.firewall_rule_collection_network
  ]
}


resource "azurerm_monitor_diagnostic_setting" "firewall-diagnostics-settings" {
  name               = "${azurerm_firewall.central-firewall.name}-loganalytics"
  target_resource_id = azurerm_firewall.central-firewall.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.firewall-log_analytics_workspace.id

  log {
    category = "AzureFirewallApplicationRule"
    enabled = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AzureFirewallNetworkRule"
    enabled = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AZFWThreatIntel"
    enabled = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AZFWIdpsSignature"
    enabled = true
    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled = true
    retention_policy {
      enabled = false
    }
  }
  depends_on = [ azurerm_firewall.central-firewall ]
}


data "azurerm_firewall" "central-firewall-data" {
    name =  azurerm_firewall.central-firewall.name
    resource_group_name = "${local.resource_group_name}"
    depends_on = [
        azurerm_virtual_network.vnethub]  
}

data "azurerm_public_ip" "firewall-pip-data" {
    name =  azurerm_public_ip.firewall-pip.name
    resource_group_name = "${local.resource_group_name}"    
}

# data "azurerm_monitor_diagnostic_categories" "firewalldiag" {
#   resource_id = azurerm_firewall.central-firewall.id
# }

# output "azurerm_firewall" {
#   value = data.azurerm_monitor_diagnostic_categories.firewalldiag.logs
# }