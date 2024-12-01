# Azure Virtual Network Terraform Module

## Overview

This Terraform module creates an Azure Virtual Network (VNet) with configurable subnets, supporting advanced networking features such as service delegations and custom tagging.

## Module Structure

```
.
├── main.tf        # Primary resource definitions
├── variables.tf   # Input variable definitions
└── outputs.tf     # Module output values
```

## Features

- Create a Virtual Network with customizable address space
- Configure multiple subnets within the VNet
- Support for service delegations
- Flexible tagging
- Automatic subnet creation
- Lifecycle management with tag exceptions

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `virtual_network_name` | Name of the Virtual Network | `string` | - | Yes |
| `resource_group_name` | Name of the resource group | `string` | - | Yes |
| `location` | Azure region for resources | `string` | - | Yes |
| `virtual_network_address_space` | CIDR block for the VNet | `list(string)` | - | Yes |
| `subnets` | Map of subnet configurations | `map(object)` | - | Yes |
| `tags` | Tags to apply to the VNet | `map(string)` | `{}` | No |

### Subnet Configuration

Each subnet supports:
- `name`: Subnet name (optional)
- `address_prefixes`: CIDR blocks for the subnet
- `delegations`: Optional service delegations with:
  - `name`: Delegation name
  - `service_delegation`: 
    - `name`: Service name
    - `actions`: Allowed actions

## Usage Example

```hcl
module "vnet" {
  source = "./virtual-network-module"

  virtual_network_name           = "my-vnet"
  resource_group_name            = "my-rg"
  location                       = "eastus"
  virtual_network_address_space  = ["10.0.0.0/16"]

  subnets = {
    "frontend" = {
      address_prefixes = ["10.0.1.0/24"]
    }
    "backend" = {
      address_prefixes = ["10.0.2.0/24"]
      delegations = [{
        name = "app-service-delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }]
    }
  }

  tags = {
    Environment = "Production"
    Project     = "MyProject"
  }
}
```

## Outputs

| Name | Description |
|------|-------------|
| `virtual_network_id` | ID of the created VNet |
| `virtual_network_name` | Name of the created VNet |
| `subnets` | Full subnet resources |
| `subnet_ids` | Map of subnet names to subnet IDs |
| `subnet_names` | Map of subnet keys to subnet names |
| `subnet_address_prefixes` | Map of subnet names to address prefixes |

## Notes

- The module ignores changes to the `DateCreated` tag to prevent unnecessary updates
- Subnets are created dynamically based on the input configuration
- Service delegations can be optionally defined for each subnet

