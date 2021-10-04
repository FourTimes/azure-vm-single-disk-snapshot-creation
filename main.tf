
# create  the snapshot the disk
resource "azurerm_snapshot" "tf" {
  name                = "snapshotpspl"
  location            = data.azurerm_resource_group.tfm.location
  resource_group_name = data.azurerm_resource_group.tfm.name
  create_option       = "Copy"
  source_uri          = data.azurerm_managed_disk.tfm.id
}

# convert snapshot into managed disk
resource "azurerm_managed_disk" "source" {
  name                 = "diskpspl"
  location             = data.azurerm_resource_group.tfm.location
  resource_group_name  = data.azurerm_resource_group.tfm.name
  storage_account_type = "Standard_LRS"
  create_option        = "Copy"
  source_resource_id   = azurerm_snapshot.tfm.source_uri
  depends_on = [
    azurerm_snapshot.tf
  ]
}


module "snapshot-vm-one" {
  source = "./module"
  # New name
  vm_name = "pspl-snapshot-vm"
  # New VM size 
  vm_size = "Standard_LRS"
  # Disk resource group name
  azurerm_resource_group = data.azurerm_resource_group.tfm.name
  # Subnet name
  subnet_name = "default"
  # virtual network name
  subnet_virtual_network_name = "PSPL_ITDev"
  # networking resource group name
  network_azurerm_resource_group = "PSPL_ITDev"
  managed_disk_id                = azurerm_managed_disk.source.id
  managed_disk_type              = azurerm_managed_disk.source.storage_account_type
  additional_tags = {
    Owner       = "pspl"
    Environment = "development"
  }
}

