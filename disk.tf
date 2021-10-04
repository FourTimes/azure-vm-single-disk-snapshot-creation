
# create  the snapshot the disk
resource "azurerm_snapshot" "tf" {
  name                = "snapshotpspl"
  location            = data.azurerm_resource_group.tfm.location
  resource_group_name = data.azurerm_resource_group.tfm.name
  create_option       = "Copy"
  source_uri          = data.azurerm_managed_disk.tfm.id
}


