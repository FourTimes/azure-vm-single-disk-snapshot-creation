# azure-os-disk-snapshot-vm

```bash
# commands
terraform init
terraform plan
terraform apply -auto-approve
    
 ```
 
 
 Multiple VM snapshot use terraform
 
 
 ```hcl
 
 
module "snapshot-vm-one" {
  source                         = "./module"
  vm_name                        = "pspl-snapshot-xx"
  vm_size                        = "Standard_LRS"
  azurerm_resource_group         = "P2_STRESS_XXX"
  azurerm_managed_disk_name      = "ps-XXX"
  subnet_name                    = "XXXX"
  subnet_virtual_network_name    = "PSPL_XXXX"
  network_azurerm_resource_group = "PSPL_XXXX"
}
 
 module "snapshot-vm-two" {
  source                         = "./module"
  vm_size                        = "Standard_LRS"
  vm_name                        = "pspl-snapshot-xx"
  azurerm_resource_group         = "P2_STRESS_YYY"
  azurerm_managed_disk_name      = "ps-yyyy"
  subnet_name                    = "YYYY"
  subnet_virtual_network_name    = "PSPL_YYYY"
  network_azurerm_resource_group = "PSPL_YYYY"
}
 ```
