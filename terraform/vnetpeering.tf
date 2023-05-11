data "azurerm_virtual_network" "vnethub" {
  #provider ="azurerm.hub"
    name =  "vnet-hub-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"
    depends_on = [
        azurerm_virtual_network.vnethub]  
}
data "azurerm_virtual_network" "vnet-spoke1" {
    name = "vnet-spoke1-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"    
    depends_on = [
        azurerm_virtual_network.vnet-spoke1] 
}

data "azurerm_virtual_network" "vnet-spoke2" {
    name = "vnet-spoke2-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"    
    depends_on = [
        azurerm_virtual_network.vnet-spoke2] 
}

data "azurerm_virtual_network" "vnet-shared" {
    name =  "vnet-shared-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"    
    depends_on = [
        azurerm_virtual_network.vnet-shared] 
}

#Creamos el peering vnethub-vnetspoke1
resource "azurerm_virtual_network_peering" "peering-vnethub-vnetspoke1" {
  #provider ="azurerm.hub"
  name                      = "${data.azurerm_virtual_network.vnethub.name}-${data.azurerm_virtual_network.vnet-spoke1.name}"
  resource_group_name       = "${data.azurerm_virtual_network.vnethub.resource_group_name}"
  virtual_network_name      = "${data.azurerm_virtual_network.vnethub.name}"
  remote_virtual_network_id = "${data.azurerm_virtual_network.vnet-spoke1.id}"
  allow_forwarded_traffic=true
  allow_virtual_network_access=true
  allow_gateway_transit=false
  use_remote_gateways=false
  depends_on = [
        azurerm_virtual_network.vnethub,
        azurerm_virtual_network.vnet-spoke1]
}

resource "azurerm_virtual_network_peering" "peering-vnetspoke1-vnethub" {
  #provider ="azurerm.hub"
  name                      = "${data.azurerm_virtual_network.vnet-spoke1.name}-${data.azurerm_virtual_network.vnethub.name}"
  resource_group_name       = "${data.azurerm_virtual_network.vnet-spoke1.resource_group_name}"
  virtual_network_name      = "${data.azurerm_virtual_network.vnet-spoke1.name}"
  remote_virtual_network_id = "${data.azurerm_virtual_network.vnethub.id}"
  allow_forwarded_traffic=true
  allow_virtual_network_access=true
  allow_gateway_transit=false
  use_remote_gateways=false
  depends_on = [
        azurerm_virtual_network.vnethub,
        azurerm_virtual_network.vnet-spoke1]
}


#Creamos el peering vnethub-vnetspoke2
resource "azurerm_virtual_network_peering" "peering-vnethub-vnetspoke2" {
  #provider ="azurerm.hub"
  name                      = "${data.azurerm_virtual_network.vnethub.name}-${data.azurerm_virtual_network.vnet-spoke2.name}"
  resource_group_name       = "${data.azurerm_virtual_network.vnethub.resource_group_name}"
  virtual_network_name      = "${data.azurerm_virtual_network.vnethub.name}"
  remote_virtual_network_id = "${data.azurerm_virtual_network.vnet-spoke2.id}"
  allow_forwarded_traffic=true
  allow_virtual_network_access=true
  allow_gateway_transit=false
  use_remote_gateways=false
  depends_on = [
        azurerm_virtual_network.vnethub,
        azurerm_virtual_network.vnet-spoke2]
}

resource "azurerm_virtual_network_peering" "peering-vnetspoke2-vnethub" {
  #provider ="azurerm.hub"
  name                      = "${data.azurerm_virtual_network.vnet-spoke2.name}-${data.azurerm_virtual_network.vnethub.name}"
  resource_group_name       = "${data.azurerm_virtual_network.vnet-spoke2.resource_group_name}"
  virtual_network_name      = "${data.azurerm_virtual_network.vnet-spoke2.name}"
  remote_virtual_network_id = "${data.azurerm_virtual_network.vnethub.id}"
  allow_forwarded_traffic=true
  allow_virtual_network_access=true
  allow_gateway_transit=false
  use_remote_gateways=false
  depends_on = [
        azurerm_virtual_network.vnethub,
        azurerm_virtual_network.vnet-spoke2]
}

#Creamos el peering vnethub-vnetshared
resource "azurerm_virtual_network_peering" "peering-vnethub-vnetshared" {
  #provider ="azurerm.hub"
  name                      = "${data.azurerm_virtual_network.vnethub.name}-${data.azurerm_virtual_network.vnet-shared.name}"
  resource_group_name       = "${data.azurerm_virtual_network.vnethub.resource_group_name}"
  virtual_network_name      = "${data.azurerm_virtual_network.vnethub.name}"
  remote_virtual_network_id = "${data.azurerm_virtual_network.vnet-shared.id}"
  allow_forwarded_traffic=true
  allow_virtual_network_access=true
  allow_gateway_transit=false
  use_remote_gateways=false
  depends_on = [
        azurerm_virtual_network.vnethub,
        azurerm_virtual_network.vnet-shared]
}

resource "azurerm_virtual_network_peering" "peering-vnetshared-vnethub" {
  #provider ="azurerm.hub"
  name                      = "${data.azurerm_virtual_network.vnet-shared.name}-${data.azurerm_virtual_network.vnethub.name}"
  resource_group_name       = "${data.azurerm_virtual_network.vnet-shared.resource_group_name}"
  virtual_network_name      = "${data.azurerm_virtual_network.vnet-shared.name}"
  remote_virtual_network_id = "${data.azurerm_virtual_network.vnethub.id}"
  allow_forwarded_traffic=true
  allow_virtual_network_access=true
  allow_gateway_transit=false
  use_remote_gateways=false
  depends_on = [
        azurerm_virtual_network.vnethub,
        azurerm_virtual_network.vnet-shared]
}