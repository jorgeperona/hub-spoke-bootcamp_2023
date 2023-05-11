resource "azurerm_firewall_policy_rule_collection_group" "firewall_rule_collection_application" {
    name               = "Application_Collection_Group"
    firewall_policy_id = azurerm_firewall_policy.central-firewall-policy.id
    priority           = 2000

    application_rule_collection {
        name     = "Permit_All_Application"
        priority = 5000
        action   = "Allow"
        rule {
          name = "allow_All"
          protocols {
            type = "Http"
            port = 80
          }
          protocols {
            type = "Https"
            port = 443
          }
          source_addresses  = ["*"]
          destination_fqdns = ["*"]
        }
    }
}

