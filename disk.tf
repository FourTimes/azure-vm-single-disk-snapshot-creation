
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
  source_resource_id   = azurerm_snapshot.tf.source_uri
  depends_on = [
    azurerm_snapshot.tf
  ]
}
