data "azurerm_managed_disk" "tfm" {
  name                = var.azurerm_managed_disk_name
  resource_group_name = data.azurerm_resource_group.tfm.name
}

data "azurerm_resource_group" "tfm" {
  name = var.azurerm_resource_group
}
