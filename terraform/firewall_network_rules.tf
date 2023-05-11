resource "azurerm_firewall_policy_rule_collection_group" "firewall_rule_collection_network" {
    name               = "Network_Collection_Group"
    firewall_policy_id  = azurerm_firewall_policy.central-firewall-policy.id
    priority           = 1000

    network_rule_collection {
        name     = "Allow_All_Network"
        priority = 5000
        action   = "Allow"
        rule {
            name                  = "Allow_Spoke1_To_Shared"
            protocols             = ["Any"] #[Any TCP UDP ICMP]
            source_addresses      = ["${var.vnet-spoke1[local.enviromentletter][0]}"]
            destination_addresses = ["${var.vnet-shared[local.enviromentletter][0]}"]
            destination_ports     = ["*"]
        }

        rule {
            name                  = "Allow_Spoke2_To_Shared"
            protocols             = ["Any"] #[Any TCP UDP ICMP]
            source_addresses      = ["${var.vnet-spoke2[local.enviromentletter][0]}"]
            destination_addresses = ["${var.vnet-shared[local.enviromentletter][0]}"]
            destination_ports     = ["*"]
        }

        rule {
            name                  = "Allow_Shared_To_Spoke1"
            protocols             = ["Any"] #[Any TCP UDP ICMP]
            source_addresses      = ["${var.vnet-shared[local.enviromentletter][0]}"]
            destination_addresses = ["${var.vnet-spoke1[local.enviromentletter][0]}"]
            destination_ports     = ["*"]
        }

                rule {
            name                  = "Allow_Shared_To_Spoke2"
            protocols             = ["Any"] #[Any TCP UDP ICMP]
            source_addresses      = ["${var.vnet-shared[local.enviromentletter][0]}"]
            destination_addresses = ["${var.vnet-spoke2[local.enviromentletter][0]}"]
            destination_ports     = ["*"]
        }

        # rule {
        #     name                  = "Permit_All_2"
        #     protocols             = ["Any"] #[Any TCP UDP ICMP]
        #     source_addresses      = ["*"]
        #     destination_addresses = ["*"]
        #     destination_ports     = ["*"]
        #}
        
        # rule {
        #     name                  = "Permit_All_3"
        #     protocols             = ["Any"] #[Any TCP UDP ICMP]
        #     source_addresses      = ["*"]
        #     destination_addresses = ["*"]
        #     destination_ports     = ["*"]
        # }
    }
}