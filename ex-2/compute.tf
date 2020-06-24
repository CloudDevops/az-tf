 module "linuxservers-w" {
    source                        = "Azure/compute/azurerm"
    resource_group_name           = azurerm_resource_group.rg-w.name
    vm_hostname                   = "linuxvm"
    nb_public_ip                  = 0
    remote_port                   = "22"
    nb_instances                  = 2
    vm_os_publisher               = "Canonical"
    vm_os_offer                   = "UbuntuServer"
    vm_os_sku                     = "18.04-LTS"
    vnet_subnet_id                = module.vnet-w.vnet_subnets[0]
    boot_diagnostics              = true
    delete_os_disk_on_termination = true
    nb_data_disk                  = 2
    data_disk_size_gb             = 64
    data_sa_type                  = "Premium_LRS"
    enable_ssh_key                = true
    vm_size                       = "Standard_D4s_v3"

    tags = {
      environment = "west-vms"
      costcenter  = "it"
    }

}

 module "linuxservers-e" {
   source                        = "Azure/compute/azurerm"
   resource_group_name           = azurerm_resource_group.rg-e.name
   vm_hostname                   = "linuxvm"
   nb_public_ip                  = 0
   remote_port                   = "22"
   nb_instances                  = 2
   vm_os_publisher               = "Canonical"
   vm_os_offer                   = "UbuntuServer"
   vm_os_sku                     = "18.04-LTS"
   vnet_subnet_id                = module.vnet-e.vnet_subnets[0]
   boot_diagnostics              = true
   delete_os_disk_on_termination = true
   nb_data_disk                  = 2
   data_disk_size_gb             = 64
   data_sa_type                  = "Premium_LRS"
   enable_ssh_key                = true
   vm_size                       = "Standard_D4s_v3"

   tags = {
     environment = "east-vms"
     costcenter  = "it"
   }

   enable_accelerated_networking = true
 }
