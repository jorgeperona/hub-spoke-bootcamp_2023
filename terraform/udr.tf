##UDR Spoke1
resource "azurerm_route_table" "udr-spoke1" {
    name = "udr-spoke1-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    disable_bgp_route_propagation = true

    route {
        name           = "default_0.0.0.0_0"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Spoke1"
        address_prefix = "${var.vnet-spoke1[local.enviromentletter][0]}"
        next_hop_type  = "VnetLocal"
    }

   route {
        name           = "ToShared"
        address_prefix = "${var.vnet-shared[local.enviromentletter][0]}"                  
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "ToHUB_Infrastructure"
        address_prefix = "${var.infrastructure-snet[local.enviromentletter][0]}"                  
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }
}

resource "azurerm_subnet_route_table_association" "udr-spoke1-association-snet1" {
  subnet_id      = azurerm_subnet.vnet-spoke1-snet1.id
  route_table_id = azurerm_route_table.udr-spoke1.id
}

##UDR Spoke2
resource "azurerm_route_table" "udr-spoke2" {
    name = "udr-spoke2-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    disable_bgp_route_propagation = true

    route {
        name           = "default_0.0.0.0_0"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Spoke2"
        address_prefix = "${var.vnet-spoke2[local.enviromentletter][0]}"
        next_hop_type  = "VnetLocal"
    }

    route {
        name           = "ToShared"
        address_prefix = "${var.vnet-shared[local.enviromentletter][0]}"          
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "ToHUB_Infrastructure"
        address_prefix = "${var.infrastructure-snet[local.enviromentletter][0]}"                  
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

}

resource "azurerm_subnet_route_table_association" "udr-spoke2-association-snet1" {
  subnet_id      = azurerm_subnet.vnet-spoke2-snet1.id
  route_table_id = azurerm_route_table.udr-spoke2.id
}


##UDR SHARED

resource "azurerm_route_table" "udr-share" {
    name = "udr-shared-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    disable_bgp_route_propagation = true

    route {
        name           = "default_0.0.0.0_0"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Shared"
        address_prefix = "${var.vnet-shared[local.enviromentletter][0]}"
        next_hop_type  = "VnetLocal"
    }

    route {
        name           = "ToHUB_Infrastructure"
        address_prefix = "${var.infrastructure-snet[local.enviromentletter][0]}"                  
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

}

resource "azurerm_subnet_route_table_association" "udr-shared-association-snet1" {
  subnet_id      = azurerm_subnet.vnet-shared-snet1.id
  route_table_id = azurerm_route_table.udr-share.id
}

resource "azurerm_subnet_route_table_association" "udr-shared-association-snet2" {
  subnet_id      = azurerm_subnet.vnet-shared-snet2.id
  route_table_id = azurerm_route_table.udr-share.id
}

##UDR Gateway
resource "azurerm_route_table" "udr-gatewaysubnet" {
    name = "udr-gatewaysubnet-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    disable_bgp_route_propagation = false

    route {
        name           = "To_Spoke1"
        address_prefix = "${var.vnet-spoke1[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Spoke2"
        address_prefix = "${var.vnet-spoke2[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_HUB"
        address_prefix = "${var.vnethub[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Shared"
        address_prefix = "${var.vnet-shared[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    depends_on = [
      azurerm_firewall.central-firewall
    ]
}

resource "azurerm_subnet_route_table_association" "udr-gatewaysubnet-association" {
  subnet_id      = azurerm_subnet.GatewaySubnet.id
  route_table_id = azurerm_route_table.udr-gatewaysubnet.id
}

#######

##UDR HUBINfra
resource "azurerm_route_table" "udr-hubinfrasnet" {
    name = "udr-hubinfrasnet-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    disable_bgp_route_propagation = false

    route {
        name           = "To_Spoke1"
        address_prefix = "${var.vnet-spoke1[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Spoke2"
        address_prefix = "${var.vnet-spoke2[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    route {
        name           = "To_Shared"
        address_prefix = "${var.vnet-shared[local.enviromentletter][0]}"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = data.azurerm_firewall.central-firewall-data.ip_configuration[0].private_ip_address
    }

    depends_on = [
      azurerm_firewall.central-firewall
    ]
}

resource "azurerm_subnet_route_table_association" "udr-hubinfrasnet-association" {
  subnet_id      = azurerm_subnet.vnethub-infrastructure-snet.id
  route_table_id = azurerm_route_table.udr-hubinfrasnet.id
}