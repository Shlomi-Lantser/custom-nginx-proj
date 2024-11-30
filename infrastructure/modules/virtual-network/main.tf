resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network_address_space

  tags = var.tags 

  lifecycle {
    ignore_changes = [tags["DateCreated"]]
  }
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = coalesce(each.value.delegations, []) # Use coalesce to handle null delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
  depends_on = [ azurerm_virtual_network.vnet ]
}