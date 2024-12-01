# Terraform Module: Azure Kubernetes Service (AKS) with Helm Deployments

This Terraform module provisions an Azure Kubernetes Service (AKS) cluster with support for additional configurations and optional Helm chart deployments, including ArgoCD, GitHub Actions Runners, and Cert-Manager.

---

## Features

1. **AKS Cluster Setup**:
   - Configures AKS with customizable node pools.
   - Enables OIDC issuer and Key Vault secret rotation.
   - Configures networking with support for `azure` network plugin and `calico` network policy.

3. **Helm Chart Deployment**:
   - **ArgoCD**: Deploys the ArgoCD Helm chart with a configurable LoadBalancer service type.
   - **Reloader**: Deploys the Reloader Helm chart.

4. **Outputs**:
   - Provides sensitive kubeconfig information for connecting to the AKS cluster.

---

## Usage

### Module Configuration

```hcl
module "aks" {
  source = "./path-to-module"

  location            = "West Europe"
  resource_group_name = "example-resources"
  cluster_name        = "example-aks1"
  dns_prefix          = "exampleaks1"

  default_node_pool = {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>"
  }

  node_pools = {
    pool1 = {
      name           = "pool1"
      vm_size        = "Standard_DS3_v2"
      node_count     = 3
      vnet_subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>"
    }
  }

  deploy_argo        = true
  deploy_reloader = true
}
```

---

## Variables

| Name                       | Description                                                                                           | Type        | Default              |
|----------------------------|-------------------------------------------------------------------------------------------------------|-------------|----------------------|
| `location`                 | Azure region for resource deployment.                                                                | `string`     | N/A                  |
| `resource_group_name`      | Name of the Azure resource group.                                                                    | `string`     | N/A                  |
| `cluster_name`             | Name of the AKS cluster.                                                                             | `string`     | N/A                  |
| `dns_prefix`               | DNS prefix for the AKS cluster.                                                                      | `string`     | N/A                  |
| `enable_oidc`              | Deploying OIDC add-on when assigned as true                                                          | `string`     | N/A                  |
| `enable_keyvault_secret_provider`              | Deploying keyvault_secret_provider add-on when assigned as true                  | `string`     | N/A                  |
| `default_node_pool`        | Default node pool configuration.                                                                     | `object`    | N/A                  |
| `node_pools`               | Additional node pools to be added to the cluster.                                                   | `map(object)` | `{}`                |
| `deploy_argo`              | Whether to deploy ArgoCD.                                                                            | `bool`      | `false`              |
| `deploy_reloader`              | Whether to deploy Reloader.                                                                            | `bool`      | `false`              |
| `network_profile`          | Network profile for the AKS cluster. Includes plugin and policy.                                     | `object`    | `{"azure", "calico"}`|

---

## Outputs

| Name                | Description                                      |
|---------------------|--------------------------------------------------|
| `client_certificate` | Encoded client certificate for Kubernetes access. |
| `kube_config`        | Raw kubeconfig file for accessing the AKS cluster.|

---

## Optional Deployments

### ArgoCD

To deploy ArgoCD, set `deploy_argo` to `true`. The module:
- Creates the `argocd` namespace.
- Deploys the ArgoCD Helm chart with a LoadBalancer service.

### Reloader

To deploy Reloader, set `deploy_reloader` to `true`. The module:
- Deploys the Reloader Helm chart within the default namespace.

## Example Scenarios

### Simple AKS Cluster

```hcl
module "aks" {
  source = "./path-to-module"

  location            = "West Europe"
  resource_group_name = "example-resources"
  cluster_name        = "simple-cluster"
  dns_prefix          = "simpleaks"

  default_node_pool = {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = "/subscriptions/.../subnets/default"
  }

  deploy_argo = false
}
```

### AKS with GitHub ArgoCD

```hcl
module "aks" {
  source = "./path-to-module"

  location            = "West Europe"
  resource_group_name = "example-resources"
  cluster_name        = "simpleaks-with-argocd"
  dns_prefix          = "simpleaks-with-argocd"

  default_node_pool = {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = "/subscriptions/.../subnets/default"
  }

  deploy_argo = true
  deploy_reloader = true
}
```

---

## Notes

- Ensure that the necessary Azure permissions are granted for Terraform to provision AKS and deploy Helm charts.
- Secret rotation requires the Key Vault Secrets Provider feature to be enabled.

--- 