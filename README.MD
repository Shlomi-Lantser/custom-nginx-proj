# AKS Cluster Deployment with Advanced Monitoring and GitOps

## Project Overview

This project provides a comprehensive Terraform module for deploying an Azure Kubernetes Service (AKS) cluster with advanced features including:
- Multiple node pool configurations
- Network profile customization
- Optional Key Vault secret provider
- ArgoCD deployment
- Stakater Reloader integration
- Prometheus
- Alertmanager

## Terraform Module Configuration

Key configurable variables include:

## Required Information

All the required information for deploying this Terraform modules can be found in the following README files:

- [AKS Module README](./infrastructure/modules/aks/README.md)
- [VNet Module README](./infrastructure/modules/virtual-network/README.md)

Please refer to these README files for detailed instructions and configuration options specific to each module.

## Deployment Steps


### 1. Azure Authentication

```bash
# Login to Azure
az login

# Set target subscription
az account set --subscription <YOUR_SUBSCRIPTION_ID>

# Create service principal (if needed)
az ad sp create-for-rbac --name "AKSDeploymentSP" --role Contributor
```

### 2. Terraform Deployment

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply configuration
terraform apply
```

### 3. Cluster Access

```bash
# Get AKS cluster credentials
az aks get-credentials --resource-group <RESOURCE_GROUP> --name <CLUSTER_NAME>

# Verify cluster access
kubectl get pod -A
```

### 4. Helm & Manifests deployment
For information on deploying used Helm charts and using the manifests, please refer to the [manifests README](./yamls/README.md)

## Monitoring and Alerting

### Prometheus Access

```bash
# Port forward Prometheus
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090

# Access Prometheus UI: http://localhost:9090
```

### Alertmanager Acess

```bash
# Port forward Alertmanager
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-alertmanager 9093:9093
```

## ArgoCD Configuration

### Initial Setup

```bash

# Access ArgoCD admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Port forward ArgoCD server
kubectl port-forward svc/argo-cd-argocd-server -n argocd 8080:443
```

### Login and Configuration

1. Access ArgoCD UI: `https://localhost:8080`
2. Username: `admin`
3. Password: From secret above

## Troubleshooting

- ArgoCD:
  * Go to the Settings page -> Repositories and make sure the required repository appears.
  * Go to Applications page and make sure the required application is up and healthy.

- Promethues:
  * Go to the Promethues server ui -> Alerts and validate the required alert is on inactive state.

- AlertManager:
  * Go to the alertmanager ui -> status and check if the Config section is compitable with the promethues stack values.
  * To check the email notification use this command:
  ```bash
    curl -H "Content-Type: application/json" -d '[{"labels":{"alertname":"TestAlert"}}]' localhost:9093/api/v2/alerts
  ```
    you should get email notification after few seconds.
  * If you didn't recieve any email nofification check the logs of the alertmanager pod
  ```bash
    kubectl logs -n monitoring alertmanager-prom-kube-prometheus-stack-alertmanager-0
  ```
  * Use the following command to consume the nginx pod CPU to trigger an alert
  ```bash
    seq 1 10000000 | xargs -n 1 -P 1000 curl http://<YOUR_PUBLIC_LB_IP>/   
  ```

## Estimated Effort

- Initial Setup: 2-3 hours
- Configuration: 1-2 hours
- Testing: 1 hour


---

**Note**: Customize configurations according to your specific requirements.
