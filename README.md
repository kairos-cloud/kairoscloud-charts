# 🚀 KairosCloud Helm Charts

A comprehensive Helm chart for deploying KairosCloud applications on Kubernetes with extensive resource support.

## 📦 Quick Start

### Add Repository
```bash
helm repo add kairoscloud https://kairos-cloud.github.io/kairoscloud-charts/
helm repo update
```

### Install Chart
```bash
# Basic installation
helm install my-kairoscloud kairoscloud/kairoscloud-chart

# With custom values
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set image.repository=myregistry/kairoscloud \
  --set image.tag=v1.0.0
```

### Update Chart
```bash
# Update to latest version
helm upgrade my-kairoscloud kairoscloud/kairoscloud-chart

# Update with new image
helm upgrade my-kairoscloud kairoscloud/kairoscloud-chart \
  --set image.tag=v2.0.0
```

### Uninstall Chart
```bash
# Uninstall release
helm uninstall my-kairoscloud

# Uninstall with namespace
helm uninstall my-kairoscloud --namespace production
```

## 🎯 Supported Kubernetes Resources

### 🏗️ **Core Workloads**
| Resource | Description |
|----------|-------------|
| **Deployment** | Stateless applications with rolling updates |
| **StatefulSet** | Stateful applications with persistent storage |
| **DaemonSet** | Node-level workloads that run on every node |
| **Job** | Batch processing and one-time tasks |
| **CronJob** | Scheduled and recurring tasks |

### 🌐 **Networking & Services**
| Resource | Description |
|----------|-------------|
| **Service** | Internal service discovery and load balancing |
| **Ingress** | External HTTP/HTTPS access with TLS termination |
| **NetworkPolicy** | Fine-grained network security policies |
| **ServiceAccount** | RBAC and security contexts for pods |

### 💾 **Storage & Persistence**
| Resource | Description |
|----------|-------------|
| **PersistentVolumeClaim** | Persistent storage with configurable storage classes |
| **VolumeSnapshot** | Point-in-time snapshots of persistent volumes |
| **StorageClass** | Storage provisioner definitions |

### 🔐 **Configuration & Secrets**
| Resource | Description |
|----------|-------------|
| **ConfigMap** | Configuration data and environment variables |
| **Secret** | Sensitive data like passwords and API keys |

### 📈 **Autoscaling & Performance**
| Resource | Description |
|----------|-------------|
| **HorizontalPodAutoscaler** | CPU/memory-based autoscaling |
| **ScaledObject** (KEDA) | Event-driven autoscaling with 50+ supported scalers |
| **PodDisruptionBudget** | High availability during cluster disruptions |

### 🔍 **Observability & Monitoring**
| Resource | Description |
|----------|-------------|
| **ServiceMonitor** (Prometheus) | Metrics collection and monitoring |
| **PrometheusRule** | Custom alerting rules |
| **Telemetry** (Istio) | Distributed tracing and metrics in service mesh |

### 🛡️ **Resource Management**
| Resource | Description |
|----------|-------------|
| **LimitRange** | Enforcing resource limits and requests |
| **ResourceQuota** | Namespace-level resource constraints |

### 🔐 **RBAC & Security**
| Resource | Description |
|----------|-------------|
| **ClusterRole** | Cluster-wide permissions |
| **Role** | Namespace-scoped permissions |
| **ClusterRoleBinding** | Bind cluster roles to users/groups |
| **RoleBinding** | Bind roles to users/groups |

### 🌐 **Istio Service Mesh**
| Resource | Description |
|----------|-------------|
| **Gateway** | Service mesh ingress/egress configuration |
| **VirtualService** | Advanced traffic routing and load balancing |
| **AuthorizationPolicy** | Service mesh access control |
| **PeerAuthentication** | Mutual TLS (mTLS) configuration |
| **RequestAuthentication** | JWT-based authentication |

### 🔒 **Certificate Management**
| Resource | Description |
|----------|-------------|
| **Certificate** (cert-manager) | Automatic TLS certificate management |

### 🧪 **Chaos Engineering (Chaos Mesh)**
| Resource | Description |
|----------|-------------|
| **PodChaos** | Pod failure and container kill experiments |
| **NetworkChaos** | Network latency, partition, and bandwidth experiments |
| **HTTPChaos** | HTTP request delay, abort, and replace experiments |
| **StressChaos** | CPU and memory stress testing |
| **IOChaos** | Filesystem I/O chaos experiments |
| **TimeChaos** | Time skew and clock chaos experiments |
| **KernelChaos** | Kernel-level chaos experiments |
| **JVMChaos** | Java application chaos experiments |
| **AWSChaos** | AWS-specific chaos experiments |
| **GCPChaos** | Google Cloud Platform chaos experiments |
| **DNSChaos** | DNS resolution chaos experiments |
| **Workflow** | Orchestrating complex multi-step chaos experiments |

## 🎨 Usage Examples

### Basic Deployment
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart
```

### High Availability Setup
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set replicaCount=3 \
  --set autoscaling.enabled=true
```

### StatefulSet with Persistence
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set statefulset.enabled=true \
  --set persistence.enabled=true
```

### Production Setup
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set ingress.enabled=true \
  --set certificate.enabled=true \
  --set serviceMonitor.enabled=true
```

## 🔧 Prerequisites

- **Kubernetes**: 1.19+
- **Helm**: 3.2.0+
- **Optional**: Istio, Prometheus, cert-manager, KEDA, Chaos Mesh

---

**Repository**: [kairos-cloud/kairoscloud-charts](https://github.com/kairos-cloud/kairoscloud-charts)  
**Helm Repository**: `https://kairos-cloud.github.io/kairoscloud-charts/`  
**Chart Name**: `kairoscloud-chart`