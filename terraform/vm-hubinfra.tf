resource "azurerm_network_interface" "vmhubinfra-nic" {
    name  = "nic-vmhubinfra-${local.enviromentletter}-${local.regioncode}"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnethub-infrastructure-snet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "${var.ip-vm-vmhubinfra[local.enviromentletter]}"
  }
}

resource "azurerm_windows_virtual_machine" "vmhubinfra" {
    name  = "vmhubinfra${local.enviromentletter}"
    resource_group_name = "${local.resource_group_name}"          
    location            = "${local.location}" 
    size                = "Standard_B2ms"
    admin_username      = "adminuser"
    admin_password      = "P@$$w0rd1234!-jpp.test30"
        network_interface_ids = [
            azurerm_network_interface.vmhubinfra-nic.id,
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
    depends_on = [ azurerm_windows_virtual_machine.vmshared1 ]
}

resource "azurerm_virtual_machine_extension" "bginfo-vmhubinfra" {
    name                 = "BGInfo"
    virtual_machine_id   = azurerm_windows_virtual_machine.vmhubinfra.id
    publisher            = "Microsoft.Compute"
    type                 = "BGInfo"
    type_handler_version = "2.1"
}

# Configure VM with extension
resource "azurerm_virtual_machine_extension" "web_server_install-vmhubinfra" {
  name                       = "vmhubinfra-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.vmhubinfra.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted ; New-NetFirewallRule -DisplayName Allow_All -Direction Inbound -LocalPort Any -Protocol Any -Action Allow -Profile Any ; $nic = Get-NetAdapter ; Set-DnsClient -InterfaceIndex $nic.ifIndex -ConnectionSpecificSuffix sbsconsulting.es -RegisterThisConnectionsAddress $true -UseSuffixWhenRegistering $true"
    }
  SETTINGS
}