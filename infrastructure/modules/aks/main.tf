# Define the primary Azure Kubernetes Service (AKS) cluster resource.
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  # General configuration
  name                = var.cluster_name                          # Name of the AKS cluster.
  location            = var.location                              # Location/region of the cluster.
  resource_group_name = var.resource_group_name                   # Resource group containing the AKS cluster.
  node_resource_group = var.infrastructure_resource_group_name    # Resource group for AKS-managed resources.
  dns_prefix          = var.cluster_name                          # DNS prefix for the cluster.
  oidc_issuer_enabled = var.enable_oidc                           # Enable OIDC issuer for workload identity.
  private_cluster_enabled = var.enable_private_cluster            # Enable private cluster mode for enhanced security.

  # Configure Key Vault secrets provider, if enabled.
  dynamic "key_vault_secrets_provider" {
    for_each = var.enable_keyvault_secret_provider ? [1] : []     # Enable only if specified in variables.
    content {
      secret_rotation_enabled  = true                             # Enable automatic secret rotation.
      secret_rotation_interval = "1m"                             # Rotation interval for secrets.
    }
  }

  # Network profile for the cluster.
  network_profile {
    network_plugin       = var.network_profile.network_plugin     # Specify the network plugin (e.g., kubenet or azure).
    network_plugin_mode  = var.network_profile.network_plugin == "azure" ? "overlay" : "" # Use overlay mode for 'azure' plugin.
    service_cidr         = var.service_cidr                       # CIDR block for Kubernetes services.
    dns_service_ip       = var.dns_service_ip                     # DNS IP for Kubernetes services.
  }

  # Default node pool configuration.
  default_node_pool {
    name       = var.default_node_pool.name                       # Name of the default node pool.
    node_count = var.default_node_pool.node_count                 # Number of nodes in the pool.
    vm_size    = var.default_node_pool.vm_size                    # Virtual machine size for nodes.
    vnet_subnet_id = var.default_node_pool.vnet_subnet_id         # Subnet for the node pool.

    # Upgrade settings for the node pool.
    upgrade_settings {
      drain_timeout_in_minutes      = 0                           # Time to wait for draining nodes.
      max_surge                     = "10%"                       # Max surge during upgrade as a percentage of total nodes.
      node_soak_duration_in_minutes = 0                           # Node soak duration after upgrade.
    }
  }

  # Configure system-assigned managed identity for the cluster.
  identity {
    type = "SystemAssigned"
  }

  # Lifecycle settings.
  lifecycle {
    ignore_changes = [ tags["DateCreated"] ]                      # Ignore changes to the 'DateCreated' tag.
  }
}

# Define additional node pools for the AKS cluster.
resource "azurerm_kubernetes_cluster_node_pool" "nodepools" {
  # Iterate over all node pools defined in the variables.
  for_each            = var.node_pools
  name                = each.value.name                           # Name of the node pool.
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id # Reference to the AKS cluster ID.
  vm_size             = each.value.vm_size                        # Virtual machine size for nodes in this pool.
  node_count          = each.value.node_count                     # Number of nodes in the pool.
  vnet_subnet_id      = each.value.vnet_subnet_id                 # Subnet for this node pool.
}
