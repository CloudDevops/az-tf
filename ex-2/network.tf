provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-w" {
  name     = "my-west-resources"
  location = local.west_loc
}

module "vnet-w" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.rg-w.name
  address_space       = [local.west_cidr]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.ssh-w.id
    subnet2 = azurerm_network_security_group.ssh-w.id
    subnet3 = azurerm_network_security_group.ssh-w.id
  }

  tags = {
    environment = "west"
    costcenter  = "it"
  }
}


resource "azurerm_network_security_group" "ssh-w" {
#  depends_on          = ["module.vnet-w"]
  name                = "ssh-w"
  location            = "uswest"
#  resource_group_name = "${var.resource_group_name}"
  resource_group_name = azurerm_resource_group.rg-w.name

  security_rule {
    name                       = "test"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}



 resource "azurerm_resource_group" "rg-e" {
   name     = "my-east-resources"
   location = local.east_loc
 }

 module "vnet-e" {
   source              = "Azure/vnet/azurerm"
   resource_group_name = azurerm_resource_group.rg-e.name
   address_space       = ["10.1.0.0/16"]
   subnet_prefixes     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
   subnet_names        = ["subnet1", "subnet2", "subnet3"]

   nsg_ids = {
     subnet1 = azurerm_network_security_group.ssh-e.id
     subnet2 = azurerm_network_security_group.ssh-e.id
     subnet3 = azurerm_network_security_group.ssh-e.id
   }

   tags = {
     environment = "east"
     costcenter  = "it"
   }
 }

 resource "azurerm_network_security_group" "ssh-e" {
 #  depends_on          = ["module.vnet-e"]
   name                = "ssh-e"
   location            = "useast"
 #  resource_group_name = "${var.resource_group_name}"
   resource_group_name = azurerm_resource_group.rg-e.name

   security_rule {
     name                       = "test"
     priority                   = 100
     direction                  = "Inbound"
     access                     = "Allow"
     protocol                   = "Tcp"
     source_port_range          = "*"
     destination_port_range     = "22"
     source_address_prefix      = "*"
     destination_address_prefix = "*"
   }

 }
