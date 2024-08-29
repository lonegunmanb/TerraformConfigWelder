resource "azurerm_machine_learning_compute_instance" "example" {
  machine_learning_workspace_id = azurerm_machine_learning_workspace.example.id
  name                          = "example"
  virtual_machine_size          = "STANDARD_DS2_V2"
  authorization_type            = "personal"
  description                   = "foo"
  subnet_resource_id            = azurerm_subnet.example.id
  tags = {
    foo = "bar"
  }

  ssh {
    public_key = var.ssh_key
  }
}