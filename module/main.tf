# create  the snapshot the disk
resource "azurerm_snapshot" "tf" {
  name                = "snapshot_${var.vm_name}"
  location            = data.azurerm_resource_group.tf.location
  resource_group_name = data.azurerm_resource_group.tf.name
  create_option       = "Copy"
  source_uri          = data.azurerm_managed_disk.tf.id
}


# convert snapshot into managed disk
resource "azurerm_managed_disk" "source" {
  name                 = "disk_${var.vm_name}"
  location             = data.azurerm_resource_group.tf.location
  resource_group_name  = data.azurerm_resource_group.tf.name
  storage_account_type = "Standard_LRS"
  create_option        = "Copy"
  source_resource_id   = azurerm_snapshot.tf.source_uri
  depends_on = [
    azurerm_snapshot.tf
  ]
}

resource "azurerm_public_ip" "tf" {
  name                = "IP_${var.vm_name}"
  location             = data.azurerm_resource_group.tf.location
  resource_group_name  = data.azurerm_resource_group.tf.name
  allocation_method   = "Dynamic"
}


# Create the instance of the NIC
resource "azurerm_network_interface" "tf" {
  name                = "${var.vm_name}-inc"
  location            = data.azurerm_resource_group.tf.location
  resource_group_name = data.azurerm_resource_group.tf.name
  
  ip_configuration {
    name                          = lower(var.vm_name)
    subnet_id                     = data.azurerm_subnet.tf.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf.id
  }
  depends_on = [
    azurerm_managed_disk.source
  ]
}

# Create the instance from managed disk snapshot
resource "azurerm_virtual_machine" "tf" {
  location              = data.azurerm_resource_group.tf.location
  resource_group_name   = data.azurerm_resource_group.tf.name
  name                  = var.vm_name
  network_interface_ids = [azurerm_network_interface.tf.id]
  tags                  = var.additional_tags
  vm_size               = var.vm_size
  zones                 = []
    storage_os_disk {
      caching                   = "ReadWrite"
      create_option             = "Attach"
      name                      = "disk_${var.vm_name}"
      os_type                   = "Windows"
      write_accelerator_enabled = false
      managed_disk_id           = azurerm_managed_disk.source.id
      managed_disk_type         = azurerm_managed_disk.source.storage_account_type
      disk_size_gb              = 128
    }
  depends_on = [
    azurerm_network_security_group.tf,
    azurerm_network_interface.tf
  ]
}


resource "azurerm_network_security_group" "tf" {
  name                = "${var.vm_name}-SG"
  location              = data.azurerm_resource_group.tf.location
  resource_group_name   = data.azurerm_resource_group.tf.name
  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_network_interface.tf
  ]
}


resource "azurerm_network_interface_security_group_association" "tf" {
  network_interface_id      = azurerm_network_interface.tf.id
  network_security_group_id = azurerm_network_security_group.tf.id
  depends_on = [
    azurerm_network_security_group.tf,
    azurerm_network_interface.tf
  ]
}
