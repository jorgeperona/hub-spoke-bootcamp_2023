resource "azurerm_public_ip" "publicwaf-pip" {
    name  = "publicwaf-${local.enviromentletter}-${local.regioncode}-PIP"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 
    allocation_method   = "Static"
    sku                 = "Standard"
    domain_name_label = "${var.publicwafdomainname[local.enviromentletter]}" #bootcampjppdemopre.uksouth.cloudapp.azure.com
}

locals {
    backend_address_pool_name      = "bePool-vmspoke2"
    frontend_port_name             = "feport"
    frontend_ip_configuration_name = "feip"
    http_setting_name              = "httsettings-test"
    listener_name                  = "httpListener-test"
    request_routing_rule_name      = "ruleRequest-test"
    redirect_configuration_name    = "redirect-test"
}

resource "azurerm_application_gateway" "public_waf" {
    name                = "publicwaf-${local.enviromentletter}-${local.regioncode}"
        resource_group_name = "${local.resource_group_name}"          
        location            = "${local.location}" 

    sku {
        name     = "Standard_v2"
        tier     = "Standard_v2"
        capacity = 1
    }

    gateway_ip_configuration {
        name      = "publicwaf-gateway_ip_configuration"
        subnet_id = azurerm_subnet.PublicWAFSnet.id
    }

    frontend_port {
        name = local.frontend_port_name
        port = 80
    }

    frontend_ip_configuration {
        name                 = local.frontend_ip_configuration_name
        public_ip_address_id = azurerm_public_ip.publicwaf-pip.id
    }

    backend_address_pool {
        name = local.backend_address_pool_name
        ip_addresses = ["${var.ip-vm-spoke2[local.enviromentletter]}"]
    }

    backend_http_settings {
        name                  = local.http_setting_name
        cookie_based_affinity = "Disabled"
        path                  = ""
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
    }

    http_listener {
        name                           = local.listener_name
        frontend_ip_configuration_name = local.frontend_ip_configuration_name
        frontend_port_name             = local.frontend_port_name
        protocol                       = "Http"
    }

    request_routing_rule {
        name                       = local.request_routing_rule_name
        rule_type                  = "Basic"
        http_listener_name         = local.listener_name
        backend_address_pool_name  = local.backend_address_pool_name
        backend_http_settings_name = local.http_setting_name
    }
}