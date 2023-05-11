#Subscription and Location
variable "RG_NAME" {
  type        = string
  description = "Name of the Resource Group"
}

variable "TENANTID"  {
    type = string
}

variable "SUBSCRIPTION" {
  type = string
}

variable "DEPLOYMENTLOCATION" {
  type = string
}

variable "ENVIRONMENTNAME" {
  type = string
  #default = "pre"
} #Valores permitidos "pre" y "pro"


/* variable "enviromentName" {
  default = "pre"
} #Valores permitidos "pre" y "pro" */

#Etiquetas
variable "tags" {
  type=map (string)
  default = {
      Environment = "pre"
      Project = "JPP Test"
  }
}


variable "regioncodedefinition" {
  type=map (string)
  default = {
    westeurope="weu"
    northeurope="neu"
    eastus = "eus"
    centralus ="cus"
    westus = "wus"
    southcentralus = "scus"
    uksouth = "suk"

  }
}

variable "enviromentletterdefinition" {
  type=map (string)
  default = {
    des="des"
    pre="pre" #Letter for PRE Environment resources names
    pro="pro" #Letter for PRO Environment resources names in WestEurope
  }
}


#IP Configuration Variables#


##VNETs VARIABLES

###VNET HUB

variable "dnsserver"{
  type=map      
  default = {    
      pre=["10.80.3.10"]
      pro=["10.90.3.10"]
  }
}

variable "vnethub"{
  type=map      
  default = {    
      pre=["10.80.10.0/23"]
      pro=["10.90.10.0/23"]
  }
}

variable "firewallsnet"{
  type=map     
  default = {    
      pre=["10.80.10.0/26"]
      pro=["10.90.10.0/26"]
  }
}

variable "firewalldomainname"{
  type=map     
  default = {    
      pre="bootcampjppdemofwpre"
      pro="bootcampjppdemofwpro"
  }
}

variable "publicwafdomainname"{
  type=map     
  default = {    
      pre="bootcampjppdemopre"
      pro="bootcampjppdemopro"
  }
}

variable "gatewaysnet"{
  type=map     
  default = {    
      pre=["10.80.10.64/26"]
      pro=["10.90.10.64/26"]
  }
}

variable "infrastructure-snet"{
  type=map     
  default = {    
      pre=["10.80.10.128/27"]
      pro=["10.90.10.128/27"]
  }
}

variable "bastionsnet"{
  type=map     
  default = {    
      pre=["10.80.10.192/26"]
      pro=["10.90.10.192/26"]
  }
}

variable "PublicWAFSnet"{
  type=map     
  default = {    
      pre=["10.80.11.0/26"]
      pro=["10.90.11.0/26"]
  }
}

variable "PrivateWAFSnet"{
  type=map     
  default = {    
      pre=["10.80.11.64/26"]
      pro=["10.90.11.64/26"]
  }
}

###VNET SPOKE1
variable "vnet-spoke1"{
  type=map      
  default = {    
      pre=["10.80.1.0/24"]
      pro=["10.90.1.0/24"]
  }
}

variable "vnet-spoke1-gatewaysnet"{
  type=map     
  default = {    
      pre=["10.80.1.0/26"]
      pro=["10.90.1.0/26"]
  }
}
variable "vnet-spoke1-snet1"{
  type=map     
  default = {    
      pre=["10.80.1.64/27"]
      pro=["10.90.1.64/27"]
  }
}

###VNET SPOKE2
variable "vnet-spoke2"{
  type=map      
  default = {    
      pre=["10.80.2.0/24"]
      pro=["10.90.2.0/24"]
  }
}

variable "vnet-spoke2-gatewaysnet"{
  type=map     
  default = {    
      pre=["10.80.2.0/26"]
      pro=["10.90.2.0/26"]
  }
}
variable "vnet-spoke2-snet1"{
  type=map     
  default = {    
      pre=["10.80.2.64/27"]
      pro=["10.90.2.64/27"]
  }
}
variable "vnet-spoke2-snet2"{
  type=map     
  default = {    
      pre=["10.80.2.128/27"]
      pro=["10.90.2.128/27"]
  }
}

variable "vnet-spoke2-snet3"{
  type=map     
  default = {    
      pre=["10.80.2.192/27"]
      pro=["10.90.2.192/27"]
  }
}


###VNET SHARED
variable "vnet-shared"{
  type=map      
  default = {    
      pre=["10.80.3.0/24"]
      pro=["10.90.3.0/24"]
  }
}

variable "vnet-shared-snet1"{
  type=map     
  default = {    
      pre=["10.80.3.0/27"]
      pro=["10.90.3.0/27"]
  }
}
variable "vnet-shared-snet2"{
  type=map     
  default = {    
      pre=["10.80.3.32/27"]
      pro=["10.90.3.32/27"]
  }
}

##Firewall Variables
variable "centralFirewall-sku" {
  default = "Premium"
}

##VMs Variables
variable "ip-vm-spoke1"{
  type=map     
  default = {    
      pre="10.80.1.68"
      pro="10.90.1.68"
  }
}

variable "ip-vm-spoke2"{
  type=map     
  default = {    
      pre="10.80.2.68"
      pro="10.90.2.68"
  }
}

variable "ip-vm-shared"{
  type=map     
  default = {    
      pre="10.80.3.10"
      pro="10.90.3.10"
  }
}

variable "ip-vm-vmhubinfra"{
  type=map     
  default = {    
      pre="10.80.10.132"
      pro="10.90.10.132"
  }
}


variable "ip-privatewaf"{
  type=map     
  default = {    
      pre="10.80.11.70"
      pro="10.90.11.70"
  }
}




