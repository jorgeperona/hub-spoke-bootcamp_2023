resource "azurerm_user_assigned_identity" "example" {
  name                = "central-firewall-identity-${local.enviromentletter}-${local.regioncode}"
  resource_group_name = "${local.resource_group_name}" 
  location            = "${local.location}" 
}

resource "azurerm_firewall_policy" "central-firewall-policy" {
  name                = "central-firewall-policy-${local.enviromentletter}-${local.regioncode}"
  resource_group_name = "${local.resource_group_name}" 
  location            = "${local.location}" 
  sku = "${var.centralFirewall-sku}"

  dns {
    servers = "${var.dnsserver[local.enviromentletter]}"
  }

  intrusion_detection {
    mode = "Alert"

  }

  threat_intelligence_mode = "Alert"

  depends_on = [ azurerm_public_ip.firewall-pip ]
}