
# Nginx Helm Chart

## Overview

This Helm chart deploys a simple Nginx web application with configurable settings using Kubernetes resources including Deployment, Service, and ConfigMap.

## Chart Structure

```
.
├── Chart.yaml
├── templates/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   └── service.yaml
└── values.yaml
```

## Templates Explained

### ConfigMap (`configmap.yaml`)
- Creates a ConfigMap with a custom `index.html` of the nginx application
- Allows dynamic customization of the webpage content
- Supports a custom header via `.Values.customHeader`

### Deployment (`deployment.yaml`)
- Deploys an Nginx container
- Configurable replica count
- Mounts the ConfigMap as a volume to replace the default `index.html`
- Sets resource limits for memory and CPU

### Service (`service.yaml`)
- Exposes the Nginx deployment as a LoadBalancer service
- Uses dynamic naming based on `appName`

## Configuration

### Values.yaml Parameters

| Parameter | Description 
|-----------|-------------|
| `appName` | Name of the application
| `namespace` | Kubernetes namespace
| `replicas` | Number of pod replicas
| `customHeader` | Custom header text for the webpage
| `configmap.name` | Name of the ConfigMap
| `container.image` | The image of the Container
| `container.resources.limits.memory` | Memory limit for the container
| `container.resources.limits.cpu` | CPU limit for the container

## Installation

### Install the chart
```bash
helm install my-nginx-release ./nginx-chartin
```
### Customize values
```bash

helm install my-nginx-release ./nginx-chart --set customHeader="Hello Azure AKS"
```

## Customization Example
### Custom values.yaml
```yaml

appName: nginx-custom-index

namespace: custom-nginx

replicas: 1

configmap:
  name: nginx-custom-index-cm
  customHeader: "Welcome to Azure AKS!"


container:
  name: nginx
  image: nginx:latest
  resources:
    limits:
      memory: "256Mi"
      cpu: "1"

```

