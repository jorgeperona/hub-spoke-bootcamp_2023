#Create Virtual Network HUB
resource "azurerm_virtual_network" "vnethub" {
    name =  "vnet-hub-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"        
    address_space       = "${var.vnethub[local.enviromentletter]}"    
    location            = "${local.location}" 
    dns_servers = "${var.dnsserver[local.enviromentletter]}"
    tags = "${var.tags}"   

    depends_on = [
        azurerm_network_security_group.nsg-vnet-hub
    ]
}

##VNET HUB Subnets
resource "azurerm_subnet" "AzureFirewallSubnet" {    
    name                 = "AzureFirewallSubnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnethub.name}"
    address_prefixes = "${var.firewallsnet[local.enviromentletter]}"    
}


resource "azurerm_subnet" "GatewaySubnet" {    
    name                 = "GatewaySubnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnethub.name}"
    address_prefixes = "${var.gatewaysnet[local.enviromentletter]}"    
}

resource "azurerm_subnet" "AzureBastionSubnet" {    
    name                 = "AzureBastionSubnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnethub.name}"
    address_prefixes = "${var.bastionsnet[local.enviromentletter]}"    
}

resource "azurerm_subnet" "PublicWAFSnet" {    
    name                 = "PublicWAFSnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnethub.name}"
    address_prefixes = "${var.PublicWAFSnet[local.enviromentletter]}"    
}

resource "azurerm_subnet" "PrivateWAFSnet" {    
    name                 = "PrivateWAFSnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnethub.name}"
    address_prefixes = "${var.PrivateWAFSnet[local.enviromentletter]}"    
}

resource "azurerm_subnet" "vnethub-infrastructure-snet" {    
    name =  "snet-vnet-hub-${local.enviromentletter}-${local.regioncode}-infrastructure"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnethub.name}"
    address_prefixes = "${var.infrastructure-snet[local.enviromentletter]}"    
}

resource "azurerm_subnet_network_security_group_association" "vnethub-infrastructure-snet-nsg-asociation" {
  subnet_id                 = azurerm_subnet.vnethub-infrastructure-snet.id
  network_security_group_id = azurerm_network_security_group.nsg-vnet-hub.id
}

#Create Virtual Network Spoke1
resource "azurerm_virtual_network" "vnet-spoke1" {
    name =  "vnet-spoke1-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"        
    address_space       = "${var.vnet-spoke1[local.enviromentletter]}"    
    location            = "${local.location}" 
    dns_servers = "${var.dnsserver[local.enviromentletter]}"
    tags = "${var.tags}"   

    depends_on = [
        azurerm_network_security_group.nsg-vnet-spoke1
    ]
}

##VNET Spoke1 Subnets
resource "azurerm_subnet" "vnet-spoke1-gatewaysnet" {    
    name                 = "GatewaySubnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnet-spoke1.name}"
    address_prefixes = "${var.vnet-spoke1-gatewaysnet[local.enviromentletter]}"    
}


resource "azurerm_subnet" "vnet-spoke1-snet1" {    
    name =  "snet-vnet-spoke1-${local.enviromentletter}-${local.regioncode}-snet1"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnet-spoke1.name}"
    address_prefixes = "${var.vnet-spoke1-snet1[local.enviromentletter]}"    
}
resource "azurerm_subnet_network_security_group_association" "vnet-spoke1-snet1-nsg-asociation" {
  subnet_id                 = azurerm_subnet.vnet-spoke1-snet1.id
  network_security_group_id = azurerm_network_security_group.nsg-vnet-spoke1.id
}



#Create Virtual Network Spoke2
resource "azurerm_virtual_network" "vnet-spoke2" {
    name =  "vnet-spoke2-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"        
    address_space       = "${var.vnet-spoke2[local.enviromentletter]}"    
    location            = "${local.location}" 
    dns_servers = "${var.dnsserver[local.enviromentletter]}"
    tags = "${var.tags}"   

    depends_on = [
        azurerm_network_security_group.nsg-vnet-spoke2
    ]
}



##VNET Spoke2 Subnets
resource "azurerm_subnet" "vnet-spoke2-gatewaysnet" {    
    name                 = "GatewaySubnet"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnet-spoke2.name}"
    address_prefixes = "${var.vnet-spoke2-gatewaysnet[local.enviromentletter]}"    
}


resource "azurerm_subnet" "vnet-spoke2-snet1" {    
    name =  "snet-vnet-spoke2-${local.enviromentletter}-${local.regioncode}-snet1"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnet-spoke2.name}"
    address_prefixes = "${var.vnet-spoke2-snet1[local.enviromentletter]}"    
}
resource "azurerm_subnet_network_security_group_association" "vnet-spoke2-snet1-nsg-asociation" {
  subnet_id                 = azurerm_subnet.vnet-spoke2-snet1.id
  network_security_group_id = azurerm_network_security_group.nsg-vnet-spoke2.id
}

# resource "azurerm_subnet" "vnet-spoke2-snet2" {    
#     name =  "snet-vnet-spoke2-${local.enviromentletter}-${local.regioncode}-snet2"
#     resource_group_name = "${local.resource_group_name}"          
#     virtual_network_name = "${azurerm_virtual_network.vnet-spoke2.name}"
#     address_prefixes = "${var.vnet-spoke2-snet2[local.enviromentletter]}"
#     #service_endpoints    = ["Microsoft.Sql","Microsoft.AzureCosmosDB","Microsoft.KeyVault","Microsoft.Storage"]
# }
# resource "azurerm_subnet_network_security_group_association" "vnet-spoke2-snet2-nsg-asociation" {
#   subnet_id                 = azurerm_subnet.vnet-spoke2-snet2.id
#   network_security_group_id = azurerm_network_security_group.nsg-vnet-spoke2.id
# }

# resource "azurerm_subnet" "vnet-spoke2-snet3" {    
#     name =  "snet-vnet-spoke2-${local.enviromentletter}-${local.regioncode}-snet3"
#     resource_group_name = "${local.resource_group_name}"          
#     virtual_network_name = "${azurerm_virtual_network.vnet-spoke2.name}"
#     address_prefixes = "${var.vnet-spoke2-snet3[local.enviromentletter]}"
#     #service_endpoints    = ["Microsoft.Sql","Microsoft.AzureCosmosDB","Microsoft.KeyVault","Microsoft.Storage"]
#    network_security_group_id = "${azurerm_network_security_group.nsg-rules-vnet-spoke1.id}"
# }
# resource "azurerm_subnet_network_security_group_association" "vnet-spoke2-snet3-nsg-asociation" {
#   subnet_id                 = azurerm_subnet.vnet-spoke2-snet3.id
#   network_security_group_id = azurerm_network_security_group.nsg-vnet-spoke2.id
# }

#Create Virtual Network Shared
resource "azurerm_virtual_network" "vnet-shared" {
    name =  "vnet-shared-${local.enviromentletter}-${local.regioncode}"    
    resource_group_name = "${local.resource_group_name}"        
    address_space       = "${var.vnet-shared[local.enviromentletter]}"    
    location            = "${local.location}" 
    dns_servers = "${var.dnsserver[local.enviromentletter]}"
    tags = "${var.tags}"   

    depends_on = [
        azurerm_network_security_group.nsg-vnet-shared
    ]
}

##VNET Shared Subnets
resource "azurerm_subnet" "vnet-shared-snet1" {    
    name =  "subnet-vnet-shared-${local.enviromentletter}-${local.regioncode}-snet1"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnet-shared.name}"
    address_prefixes = "${var.vnet-shared-snet1[local.enviromentletter]}"    
}
resource "azurerm_subnet_network_security_group_association" "vnet-shared-snet1-nsg-asociation" {
  subnet_id                 = azurerm_subnet.vnet-shared-snet1.id
  network_security_group_id = azurerm_network_security_group.nsg-vnet-shared.id
}

resource "azurerm_subnet" "vnet-shared-snet2" {    
    name =  "subnet-vnet-shared-${local.enviromentletter}-${local.regioncode}-snet2"
    resource_group_name = "${local.resource_group_name}"          
    virtual_network_name = "${azurerm_virtual_network.vnet-shared.name}"
    address_prefixes = "${var.vnet-shared-snet2[local.enviromentletter]}"    
}
resource "azurerm_subnet_network_security_group_association" "vnet-shared-snet2-nsg-asociation" {
  subnet_id                 = azurerm_subnet.vnet-shared-snet2.id
  network_security_group_id = azurerm_network_security_group.nsg-vnet-shared.id
}