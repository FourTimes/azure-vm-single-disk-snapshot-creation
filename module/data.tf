data "azurerm_resource_group" "tf" {
  name = var.azurerm_resource_group                          # Disk resource group name
}


data "azurerm_subnet" "tf" {
  name                 = var.subnet_name                     # subnet name
  virtual_network_name = var.subnet_virtual_network_name     # vnet name
  resource_group_name  = var.network_azurerm_resource_group  # vnet resource group name
}