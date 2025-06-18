provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "main-vnet"
  address_space       = ["10.0.0.0/16"] 
  location            = azurerm_resource_group.main.location     #same region as RG
  resource_group_name = azurerm_resource_group.main.name         
}
resource "azurerm_subnet" "main" {
  name                 = "main-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]        #subnet range inside the vnet

}
resource "azurerm_network_interface" "main" {
  name                = "main-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
   ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_security_group" "main" {
  name                = "main-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100                                                #Lower = Higher priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"                                                #Allow any source port
    destination_port_range     = "22"
    source_address_prefix      = "Internet"                                         #Allow traffic from anywhere (can be restricted later)
    destination_address_prefix = "*"                                                #Apply to all destination IPS
  }
}
resource "azurerm_network_interface_security_group_association" "main" {            #This association applies my security rules (like SSH) to my bm's NIC. Without this, my vm wont be protected or accessible
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "main-machine"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = "adminkb"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]
  admin_ssh_key {
  username   = "adminkb"
  public_key = file("")
}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"                                        # STnadard storage to keep costs low
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
  }
}


