
variable "location" {
    description = "Location of the resources"
    type        = string
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "infrastructure_resource_group_name" {
  description = "Name of the infrastructure resource group"
  type        = string
  nullable = true
}

variable "deploy_reloader" {
  description = "Deploy Stakater Reloader"
  type        = bool
  default     = false
}

variable "enable_private_cluster" {
    description = "Enable private cluster"
    type        = bool
}

variable "cluster_name" {
    description = "Name of the AKS cluster"
    type        = string
}

variable "enable_oidc" {
    description = "Enable OIDC"
    type        = bool
    default = false
}

variable "enable_keyvault_secret_provider" {
    description = "Enable Key Vault Secret Provider"
    type        = bool
    default     = false
}

variable "secret_rotation_interval" {
  description = "Interval for secret rotation"
  type        = string
  default     = ""

  validation {
    condition     = var.enable_keyvault_secret_provider == false || (var.enable_keyvault_secret_provider == true && var.secret_rotation_interval != "")
    error_message = "secret_rotation_interval must be set if enable_keyvault_secret_provider is true."
  }
}


variable "network_profile" {
  type = object({
    network_plugin = string
  })
}

variable "service_cidr" {
  description = "Service CIDR"
  type        = string
}

variable "dns_service_ip" {
  description = "DNS service IP"
  type        = string
}

variable "default_node_pool" {
  type = object({
    name           = string
    node_count     = number
    vm_size        = string
    vnet_subnet_id = string
  })
}



variable "node_pools" {
  description = "List of node pools"
  type        = map(object({
    name           = string
    vm_size        = string
    node_count     = number
    vnet_subnet_id = string
  }))
  default = {}
}

variable "deploy_argo" {
  description = "Deploy Argo CD"
  type        = bool
  default     = false
}

