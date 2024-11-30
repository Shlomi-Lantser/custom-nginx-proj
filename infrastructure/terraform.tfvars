# resource_group_name = "rg-aks-lab-shlomi-ne-001"

# location = "northeurope"

# virtual_network_name = "vnet-aks-lab-shlomi-ne-001"

# subnets = {
#     aks-subnet = {
#         name             = "aks-subnet"
#         address_prefixes = ["10.0.1.0/28"]
#     }
# }

# virtual_network_tags = {}

# virtual_network_address_space = ["10.0.0.0/24"]

# infrastructure_resource_group_name = "my-infrastructure-resource-group"

# cluster_name = "my-aks-cluster"

# network_profile = {
#     network_plugin = "azure"
# }

# service_cidr = "100.0.0.0/16"

# dns_service_ip = "100.0.0.10"

# default_node_pool = {
#     name           = "default-pool"
#     node_count     = 3
#     vm_size        = "Standard_D2s_v3"
#     vnet_subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/<virtual-network>/subnets/<subnet>"
# }

# node_pools = {
#     pool1 = {
#         name           = "pool1"
#         vm_size        = "Standard_D2s_v3"
#         node_count     = 3
#         vnet_subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/<virtual-network>/subnets/<subnet>"
#     }
#     pool2 = {
#         name           = "pool2"
#         vm_size        = "Standard_D4s_v3"
#         node_count     = 5
#         vnet_subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/<virtual-network>/subnets/<subnet>"
#     }
# }

# deploy_argo = false