module "snapshot-vm-one" {
  # count = var.instance_count
  source = "./module"
  managed_disk_id                = azurerm_managed_disk.source.id
  managed_disk_type              = azurerm_managed_disk.source.storage_account_type
  azurerm_resource_group         = data.azurerm_resource_group.tfm.name

  
  # New name
  vm_name = "pspl-snapshot-vm"
  # New VM size 
  vm_size = "Standard_LRS"
  # Subnet name
  subnet_name = "default"
  # virtual network name
  subnet_virtual_network_name = "PSPL_ITDev"
  # networking resource group name
  network_azurerm_resource_group = "PSPL_ITDev"
  # Tag name
  additional_tags = {
    Owner       = "pspl"
    Environment = "development"
  }
}

