#Para este test crearemos un NSG para cada VNET con Allow_All

resource "azurerm_network_security_group" "nsg-vnet-hub" {
    name =  "nsg-vnet-hub-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    tags = "${var.tags}"
}

resource "azurerm_network_security_group" "nsg-vnet-shared" {
    name =  "nsg-vnet-shared-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    tags = "${var.tags}"
}

resource "azurerm_network_security_group" "nsg-vnet-spoke1" {
    name =  "nsg-vnet-spoke1-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    tags = "${var.tags}"
}

resource "azurerm_network_security_group" "nsg-vnet-spoke2" {
    name =  "nsg-vnet-spoke2-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"           
    location            = "${local.location}" 
    tags = "${var.tags}"
}


#########################
##  CREAMOS LAS RULES  ##
#########################

##RULES PARA NSG WAF
resource "azurerm_network_security_rule" "nsg-rules-vnet-hub" {
    resource_group_name = "${local.resource_group_name}"  
    network_security_group_name = "${azurerm_network_security_group.nsg-vnet-hub.name}"
    name                       = "Allow-All"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "nsg-rules-vnet-shared" {
    resource_group_name = "${local.resource_group_name}"  
    network_security_group_name = "${azurerm_network_security_group.nsg-vnet-shared.name}"
    name                       = "Allow-All"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "nsg-rules-vnet-spoke1" {
    resource_group_name = "${local.resource_group_name}"  
    network_security_group_name = "${azurerm_network_security_group.nsg-vnet-spoke1.name}"
    name                       = "Allow-All"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "nsg-rules-vnet-spoke2" {
    resource_group_name = "${local.resource_group_name}"  
    network_security_group_name = "${azurerm_network_security_group.nsg-vnet-spoke2.name}"
    name                       = "Allow-All"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}


