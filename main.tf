module "snapshot-vm-one" {
  source                        = "./module"
  # New name
  vm_name                       = "pspl-snapshot-vm"
  # New VM size 
  vm_size                       = "Standard_LRS"
  # Disk resource group name
  azurerm_resource_group        = "P2_STRESS_TEST"
  # Existing VM Disk name
  azurerm_managed_disk_name     = "ps-azvlt001"
  # Subnet name
  subnet_name                   = "default"
  # virtual network name
  subnet_virtual_network_name   = "PSPL_ITDev"
  # networking resource group name
  network_azurerm_resource_group= "PSPL_ITDev"
  additional_tags = {
    Owner = "pspl"
    Environment = "development"
  }
}

