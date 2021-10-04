module "snapshot-vm-one" {
  # Do not changes here below 4 lines 
  source = "./module"
  source_resource_id             = azurerm_snapshot.tf.source_uri
  azurerm_resource_group         = data.azurerm_resource_group.tfm.name

  ## Changes here below as we do previous.
  # New name
  vm_name                        = "15clonepspl-snapshot-vm"
  # New VM size 
  vm_size                        = "Standard_D2s_v3"
  # Subnet name
  subnet_name                    = "default"
  # virtual network name
  subnet_virtual_network_name    = "PSPL_ITDev"
  # networking resource group name
  network_azurerm_resource_group = "PSPL_ITDev"
  # Tag name
  additional_tags = {
    Owner       = "mahesh"
    Environment = "development"
  }
}

module "snapshot-vm-two" {
  # Do not changes here below 4 lines 
  source = "./module"
  source_resource_id             = azurerm_snapshot.tf.source_uri
  azurerm_resource_group         = data.azurerm_resource_group.tfm.name

  ## Changes here below as we do previous.
  # New name
  vm_name                        = "16clonepspl-snapshot-vm"
  # New VM size 
  vm_size                        = "Standard_D2s_v3"
  # Subnet name
  subnet_name                    = "default"
  # virtual network name
  subnet_virtual_network_name    = "PSPL_ITDev"
  # networking resource group name
  network_azurerm_resource_group = "PSPL_ITDev"
  # Tag name
  additional_tags = {
    Owner       = "mahesh"
    Environment = "development"
  }
}

module "snapshot-vm-three" {
  # Do not changes here below 4 lines 
  source = "./module"
  source_resource_id             = azurerm_snapshot.tf.source_uri
  azurerm_resource_group         = data.azurerm_resource_group.tfm.name

  ## Changes here below as we do previous.
  # New name
  vm_name                        = "17clonepspl-snapshot-vm"
  # New VM size 
  vm_size                        = "Standard_D2s_v3"
  # Subnet name
  subnet_name                    = "default"
  # virtual network name
  subnet_virtual_network_name    = "PSPL_ITDev"
  # networking resource group name
  network_azurerm_resource_group = "PSPL_ITDev"
  # Tag name
  additional_tags = {
    Owner       = "mahesh"
    Environment = "development"
  }
}