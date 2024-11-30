resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  node_resource_group = var.infrastructure_resource_group_name
  dns_prefix          = var.cluster_name
  oidc_issuer_enabled = var.enable_oidc
  private_cluster_enabled = var.enable_private_cluster

  dynamic "key_vault_secrets_provider" {
    for_each = var.enable_keyvault_secret_provider ? [1] : []
    content {
      secret_rotation_enabled  = true
      secret_rotation_interval = "1m"
    }
  }

  network_profile {
    network_plugin = var.network_profile.network_plugin
    network_plugin_mode = var.network_profile.network_plugin == "azure" ? "overlay" : ""
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    vm_size    = var.default_node_pool.vm_size
    vnet_subnet_id = var.default_node_pool.vnet_subnet_id

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
      }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [ tags["DateCreated"] ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "nodepools" {
  for_each            = var.node_pools
  name               = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id
  vm_size            = each.value.vm_size
  node_count         = each.value.node_count
  vnet_subnet_id     = each.value.vnet_subnet_id
}