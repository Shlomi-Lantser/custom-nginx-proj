output "subnets" {
  value = azurerm_subnet.subnet
}

output "subnet_ids" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.id }
}

output "subnet_address_prefixes" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.address_prefixes }
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_names" {
  value = { for name, subnet in azurerm_subnet.subnet : name => subnet.name }
}