# locals {
#   rg_name                       = "rg-aks"
#   location                      = "northeurope"
#   virtual_network_address_space = ["10.0.0.0/24"]
#   subnets = {
#     subnet1 = {
#       address_prefixes = ["10.0.0.0/28"]
#     }
#   }
# }

# locals {
#   aks_infrastructure_resource_group_name = "rg-aks-infra"
#   cluster_name                           = "aks-cluster"
#   enable_private_cluster                 = false
#   enable_oidc                            = false
#   enable_keyvault_secret_provider        = false
#   network_profile = {
#     network_plugin = "azure"
#   }
#   service_cidr   = ""
#   dns_service_ip = ""

#   default_node_pool = {
#     name           = "default"
#     node_count     = 1
#     vm_size        = "Standard_B2s"
#   }
#   node_pools = {
#     pool1 = {
#       name           = "pool1"
#       node_count     = 1
#       vm_size        = "Standard_D2_v2"
#       vnet_subnet_id = "subnet_id"
#     }
#   }
# }