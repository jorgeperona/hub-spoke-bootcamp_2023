resource "azurerm_network_interface" "vmshared1-nic" {
    name  = "nic-vmshared1-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet-shared-snet1.id
    private_ip_address_allocation = "Static"
    private_ip_address = "${var.ip-vm-shared[local.enviromentletter]}"
  }
}

resource "azurerm_windows_virtual_machine" "vmshared1" {
    name  = "vmshared1${local.enviromentletter}"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 
    size                = "Standard_B2ms"
    admin_username      = "adminuser"
    admin_password      = "P@$$w0rd1234!-jpp.test30"
        network_interface_ids = [
            azurerm_network_interface.vmshared1-nic.id,
        ]
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter"
        version   = "latest"
    }
}

resource "azurerm_virtual_machine_extension" "bginfo-vmshared1" {
    name                 = "BGInfo"
    virtual_machine_id   = azurerm_windows_virtual_machine.vmshared1.id
    publisher            = "Microsoft.Compute"
    type                 = "BGInfo"
    type_handler_version = "2.1"    
}

# Install DNS server to the virtual machine
resource "azurerm_virtual_machine_extension" "web_server_install-vmshared" {
  name                       = "vmshared-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.vmshared1.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted ; Install-WindowsFeature -Name DNS -IncludeAllSubFeature -IncludeManagementTools ; Add-DnsServerPrimaryZone -Name sbsconsulting.es -ZoneFile sbsconsulting.es.dns -DynamicUpdate NonsecureAndSecure -PassThru; Add-DnsServerPrimaryZone -NetworkId 10.80.0.0/16 -ZoneFile 10_80.dns -DynamicUpdate NonsecureAndSecure ; Add-DnsServerForwarder -IPAddress 168.63.129.16 -PassThru ; New-NetFirewallRule -DisplayName Allow_All -Direction Inbound -LocalPort Any -Protocol Any -Action Allow -Profile Any ; $nic = Get-NetAdapter ; Set-DnsClient -InterfaceIndex $nic.ifIndex -ConnectionSpecificSuffix sbsconsulting.es -RegisterThisConnectionsAddress $true -UseSuffixWhenRegistering $true ; Register-DnsClient ; Add-DnsServerResourceRecordA -AllowUpdateAny -CreatePtr -ZoneName sbsconsulting.es -Name vmspoke1pre -IPv4Address 10.80.1.68 ; Add-DnsServerResourceRecordA -AllowUpdateAny -CreatePtr -ZoneName sbsconsulting.es -Name vmspoke2pre -IPv4Address 10.80.2.68 ; Add-DnsServerResourceRecordA -AllowUpdateAny -CreatePtr -ZoneName sbsconsulting.es -Name bootcampjpp -IPv4Address 10.80.2.68"
    }
  SETTINGS
}