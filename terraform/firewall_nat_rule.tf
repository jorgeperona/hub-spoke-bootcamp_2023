

output "public_ip_address" {
  value = data.azurerm_public_ip.firewall-pip-data.ip_address
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_rule_collection_nat" {
    name               = "Nat_Collection_Group"
    firewall_policy_id = azurerm_firewall_policy.central-firewall-policy.id
    priority           = 3000

    nat_rule_collection {
        name     = "NAT_RDP"
        priority = 300
        action   = "Dnat"
        rule {
            name                = "sharedvm1"
            protocols           = ["TCP"]
            source_addresses    = ["*"]
            destination_address = data.azurerm_public_ip.firewall-pip-data.ip_address
            destination_ports   = ["8390"]
            translated_address  = "${var.ip-vm-shared[local.enviromentletter]}"
            translated_port     = "3389"
        }

        rule {
            name                = "spokevm1"
            protocols           = ["TCP"]
            source_addresses    = ["*"]
            destination_address = data.azurerm_public_ip.firewall-pip-data.ip_address
            destination_ports   = ["8391"]
            translated_address  = "${var.ip-vm-spoke1[local.enviromentletter]}"
            translated_port     = "3389"
        }

        rule {
            name                = "spokevm2"
            protocols           = ["TCP"]
            source_addresses    = ["*"]
            destination_address = data.azurerm_public_ip.firewall-pip-data.ip_address
            destination_ports   = ["8392"]
            translated_address  = "${var.ip-vm-spoke2[local.enviromentletter]}"
            translated_port     = "3389"
        }

        rule {
            name                = "vmhubinfra"
            protocols           = ["TCP"]
            source_addresses    = ["*"]
            destination_address = data.azurerm_public_ip.firewall-pip-data.ip_address
            destination_ports   = ["8393"]
            translated_address  = "${var.ip-vm-vmhubinfra[local.enviromentletter]}"
            translated_port     = "3389"
        }

    }
}