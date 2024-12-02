# Output all subnet resources.
output "subnets" {
  value = azurerm_subnet.subnet
}

# Output mapping of subnet names to their IDs.
output "subnet_ids" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.id }
}

# Output mapping of subnet names to their address prefixes.
output "subnet_address_prefixes" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.address_prefixes }
}

# Output the ID of the virtual network.
output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

# Output the name of the virtual network.
output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

# Output mapping of subnet names to their names (useful for validation or reference).
output "subnet_names" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.name }
}
