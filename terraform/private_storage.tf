resource "azurerm_private_dns_zone" "dnsprivatelinkfile" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = "${local.resource_group_name}"
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnsprivatelinkfile-link" {
  name                  = "privatelink-sharedvnet-link"
  resource_group_name = "${local.resource_group_name}"
  private_dns_zone_name = azurerm_private_dns_zone.dnsprivatelinkfile.name
  virtual_network_id    = azurerm_virtual_network.vnet-shared.id
  registration_enabled = true
}

resource "azurerm_storage_account" "centralstorage" {
    name  = "centralstorage${local.enviromentletter}${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
}

resource "azurerm_storage_share" "centralstorage-share" {
  name                 = "resources"
  storage_account_name = azurerm_storage_account.centralstorage.name
  quota                = 50
}

resource "azurerm_storage_share_directory" "centralstorage-share-dir" {
  name                 = "sharedir"
  share_name           = azurerm_storage_share.centralstorage-share.name
  storage_account_name = azurerm_storage_account.centralstorage.name
}

resource "azurerm_private_endpoint" "centralstorage-pe" {
    name  = "centralstorage-pe-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 
    subnet_id           = azurerm_subnet.vnet-shared-snet2.id

    private_service_connection {
        name                           = "centralfileshare-privateserviceconnection"
        private_connection_resource_id = azurerm_storage_account.centralstorage.id
        is_manual_connection           = false
        subresource_names = ["File"]
    }

    private_dns_zone_group {
        name = "centralfileshare-dns-group"
        private_dns_zone_ids = [azurerm_private_dns_zone.dnsprivatelinkfile.id]      
    }
}

