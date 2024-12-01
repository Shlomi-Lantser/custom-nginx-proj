# Kubernetes Monitoring and Deployment Configuration

## Overview

This repository contains a set of Kubernetes configuration files for:
- Monitoring and Alerting
- Continuous Deployment
- Application Configuration

## Components

### 1. Prometheus Alerting Configuration (`prometheus-values.yaml`)

#### Purpose
Configures Prometheus and Alertmanager for cluster monitoring and alerting.

#### Key Features
- Custom email notifications
- Alert routing based on severity
- SMTP email configuration
- Disabled Grafana integration

#### Alert Notification Setup
- Uses Gmail SMTP for sending alerts
- Configured to send alerts to `shlomi.lant@gmail.com`
- 12-hour repeat interval for persistent issues

### 2. Custom Alert Rules (`custom-alert-rules.yaml`)

#### Purpose
Defines custom Prometheus alerting rules for monitoring container performance.

#### Alert Details
- **Rule Name**: ContainerHighCpuUtilization
- **Trigger Conditions**:
  - CPU usage > 80% for 30 seconds
  - Specifically monitors `nginx-custom-index` pods
- **Severity**: Warning
- **Notification**: Includes emoji and detailed description

### 3. ArgoCD Deployment Configuration

#### ArgoCD Repository Secret (`argocd-repo-secret.yaml`)
- Stores SSH private key for private GitHub repository access
- Used for secure Git repository authentication

#### ArgoCD Application (`argocd-app.yaml`)
- Configures automated deployment from GitHub repository
- Features:
  - Automatic pruning of unused resources
  - Self-healing enabled
  - Deploys to `custom-nginx-app` namespace

### 4. Alertmanager Secrets (`alertmanager-secrets.yaml`)
- Stores email credentials for alert notifications
- Uses Kubernetes Secret to manage sensitive information

## Deployment Workflow

1. ArgoCD pulls configuration from GitHub repository
2. Deploys custom Nginx application
3. Prometheus monitors container performance
4. Triggers alerts if CPU usage exceeds 80%
5. Sends email notifications via configured SMTP

## Customization

Modify the following to adapt to your environment:
- Email addresses
- SMTP configuration
- Alert thresholds
- Repository URLs

## Installation

```bash

# Create required namespace as in the argocd-app.yaml
kubectl create ns custom-nginx-app

# Apply ArgoCD Secret
kubectl apply -f argocd-repo-secret.yaml

# Apply ArgoCD Application
kubectl apply -f argocd-app.yaml

# Apply Prometheus Rules
kubectl apply -f custom-alert-rules.yaml

# Install Prometheus with custom values
helm upgrade prometheus prometheus-community/kube-prometheus-stack -f prometheus-values.yaml
```

## Troubleshooting

- Verify secrets are correctly created
- Check ArgoCD sync status
- Review Prometheus logs for alert rule issues
- Confirm SMTP settings
