#Primero obtenemos la configuración para el tenantId
data "azurerm_client_config" "current" {}

resource "random_id" "KeyVaultName" {
  byte_length = 4
}

#Creamos el KeyVault
resource "azurerm_key_vault" "example" {
  name  = "ctrkvfw${lower(random_id.KeyVaultName.id)}-${local.enviromentletter}-${local.regioncode}"
  resource_group_name = "${local.resource_group_name}"          
  location            = "${local.location}" 
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
}