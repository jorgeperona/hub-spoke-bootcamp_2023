locals {
  subscriptionID="${var.SUBSCRIPTION}"
  enviromentletter="${var.enviromentletterdefinition[var.ENVIRONMENTNAME]}"  
  resource_group_name = "${var.RG_NAME}"
  location= "${var.DEPLOYMENTLOCATION}"
  regioncode= "${var.regioncodedefinition[var.DEPLOYMENTLOCATION]}" 
}