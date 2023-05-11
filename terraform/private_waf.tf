resource "azurerm_public_ip" "privatewaf-pip" {
    name  = "privatewaf-${local.enviromentletter}-${local.regioncode}-PIP"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 
    allocation_method   = "Static"
    sku                 = "Standard"
}

locals {
    privatewaf_backend_address_pool_name      = "bePool-vmspoke2"
    privatewaf_frontend_port_name             = "feport_80"
    privatewaf_frontend_public_ip_configuration_name = "appGwPublicFrontendIp"
    privatewaf_frontend_private_ip_configuration_name = "appGwPrivateFrontendIp"
    privatewaf_http_setting_name              = "httsettings-test"
    privatewaf_listener_name                  = "httpListener-test"
    privatewaf_request_routing_rule_name      = "ruleRequest-test"
    privatewaf_redirect_configuration_name    = "redirect-test"
}

resource "azurerm_application_gateway" "private_waf" {
    name                = "privatewaf-${local.enviromentletter}-${local.regioncode}"
        resource_group_name = "${local.resource_group_name}"          
        location            = "${local.location}" 

    sku {
        name     = "Standard_v2"
        tier     = "Standard_v2"
        capacity = 1
    }

    gateway_ip_configuration {
        name      = "privatewaf-gateway_ip_configuration"
        subnet_id = azurerm_subnet.PrivateWAFSnet.id
    }

    frontend_port {
        name = local.privatewaf_frontend_port_name
        port = 80
    }

    frontend_ip_configuration {
        name                 = local.privatewaf_frontend_public_ip_configuration_name
        public_ip_address_id = azurerm_public_ip.privatewaf-pip.id
    }

    frontend_ip_configuration {
        name                 = local.privatewaf_frontend_private_ip_configuration_name
        subnet_id = azurerm_subnet.PrivateWAFSnet.id   
        private_ip_address_allocation = "Static"     
        private_ip_address = "${var.ip-privatewaf[local.enviromentletter]}"
    }


    backend_address_pool {
        name = local.privatewaf_backend_address_pool_name
        ip_addresses = ["${var.ip-vm-spoke2[local.enviromentletter]}"]
    }

    backend_http_settings {
        name                  = local.privatewaf_http_setting_name
        cookie_based_affinity = "Disabled"
        path                  = ""
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
    }

    http_listener {
        name                           = local.privatewaf_listener_name
        frontend_ip_configuration_name = local.privatewaf_frontend_private_ip_configuration_name
        frontend_port_name             = local.privatewaf_frontend_port_name
        protocol                       = "Http"
        
    }

    request_routing_rule {
        name                       = local.privatewaf_request_routing_rule_name
        rule_type                  = "Basic"
        http_listener_name         = local.privatewaf_listener_name
        backend_address_pool_name  = local.privatewaf_backend_address_pool_name
        backend_http_settings_name = local.http_setting_name
    }
}