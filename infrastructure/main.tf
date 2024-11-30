resource "azurerm_resource_group" "aks_spoke_rg" {
  name     = "rg-aks-shlomi-lab-ne-001"
  location = "northeurope"
}


module "aks_virtual_network" {
  source                        = "./modules/virtual-network"
  virtual_network_name          = "vnet-aks-shlomi-lab-ne-001"
  virtual_network_address_space = ["10.0.0.0/24"]
  location                      = azurerm_resource_group.aks_spoke_rg.location
  resource_group_name           = azurerm_resource_group.aks_spoke_rg.name

  subnets = {
    aks-subnet = {
      address_prefixes = ["10.0.0.0/28"]
    }
  }

  tags = {}
}


module "aks" {
  source                             = "./modules/aks"
  location                           = azurerm_resource_group.aks_spoke_rg.location
  resource_group_name                = azurerm_resource_group.aks_spoke_rg.name
  infrastructure_resource_group_name = "rg-aks-infra-shlomi-lab-ne-001"
  cluster_name                       = "aks-shlomi-lab-ne-001"
  enable_private_cluster             = false
  enable_oidc                        = false
  enable_keyvault_secret_provider    = false
  network_profile = {
    network_plugin = "azure"
  }
  service_cidr   = "100.0.0.0/16"
  dns_service_ip = "100.0.0.10"
  default_node_pool = {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = module.aks_virtual_network.subnet_ids["aks-subnet"]
  }
  node_pools = {
    pool1 = {
      name           = "pool1"
      node_count     = 1
      vm_size        = "Standard_D2_v2"
      vnet_subnet_id = module.aks_virtual_network.subnet_ids["aks-subnet"]
    }
  }

  deploy_argo = true

}