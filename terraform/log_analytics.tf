resource "random_id" "workspace" {
  keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = "${local.resource_group_name}" 
  }

  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "firewall-log_analytics_workspace" {
  name                = "firewall-workspace-${local.enviromentletter}-${local.regioncode}"
  location            = "${local.location}" 
  resource_group_name = "${local.resource_group_name}"
  sku                 = "PerGB2018"
}