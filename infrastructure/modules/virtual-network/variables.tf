variable "virtual_network_name" {
  type = string
  description = "Name of the Virtual Network"
}

variable "subnets" {
  description = "Map of subnets to create routes for"
  type = map(object({
    name             = optional(string)
    address_prefixes = list(string)
    delegations = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })))
  }))
}

# variable "fws_or_load_balancer_ip" {
#   description = "IP address of the load balancer or FW"
#   type        = string
# }

variable "tags" {
  type = map(string)
  description = "tags of the virtual network"
}

variable "virtual_network_address_space" {
  description = "VNet CIDR"
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location for all resources."
  type        = string
}
