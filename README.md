# KairosCloud Helm Charts

This repository contains Helm charts for deploying KairosCloud applications on Kubernetes.

## Charts

### kairoscloud-chart

A comprehensive Helm chart that supports deploying KairosCloud applications with extensive Kubernetes resource support. The chart provides templates for over 30 different Kubernetes resources organized into the following categories:

#### Core Application Resources
- **Deployment** - For stateless applications with rolling updates
- **StatefulSet** - For stateful applications with persistent storage and ordered deployment
- **Service** - For exposing applications within the cluster
- **ServiceAccount** - For RBAC and security contexts
- **ConfigMap** - For configuration data and environment variables
- **Secret** - For sensitive data like passwords and API keys

#### Storage & Persistence
- **PersistentVolumeClaim** - For persistent storage with configurable storage classes
- **VolumeSnapshot** - For creating point-in-time snapshots of persistent volumes

#### Networking & Access
- **Ingress** - For external HTTP/HTTPS access with TLS termination
- **NetworkPolicy** - For fine-grained network security policies
- **Gateway** (Istio) - For service mesh ingress/egress configuration
- **VirtualService** (Istio) - For advanced traffic routing and load balancing

#### Security & Authentication
- **RBAC** - Role-based access control with ClusterRole and Role bindings
- **AuthorizationPolicy** (Istio) - For service mesh access control
- **PeerAuthentication** (Istio) - For mutual TLS (mTLS) configuration
- **RequestAuthentication** (Istio) - For JWT-based authentication
- **Certificate** (cert-manager) - For automatic TLS certificate management

#### Autoscaling & Performance
- **HorizontalPodAutoscaler** - For CPU/memory-based autoscaling
- **ScaledObject** (KEDA) - For event-driven autoscaling with 50+ supported scalers
- **PodDisruptionBudget** - For high availability during cluster disruptions

#### Observability & Monitoring
- **ServiceMonitor** (Prometheus) - For metrics collection and monitoring
- **Telemetry** (Istio) - For distributed tracing and metrics in service mesh

#### Resource Management
- **LimitRange** - For enforcing resource limits and requests
- **ResourceQuota** - For namespace-level resource constraints

#### Workload Management
- **Job** - For batch processing and one-time tasks
- **CronJob** - For scheduled and recurring tasks

#### Chaos Engineering (Chaos Mesh)
- **PodChaos** - For pod failure and container kill experiments
- **NetworkChaos** - For network latency, partition, and bandwidth experiments
- **HTTPChaos** - For HTTP request delay, abort, and replace experiments
- **StressChaos** - For CPU and memory stress testing
- **IOChaos** - For filesystem I/O chaos experiments
- **TimeChaos** - For time skew and clock chaos experiments
- **KernelChaos** - For kernel-level chaos experiments
- **JVMChaos** - For Java application chaos experiments
- **AWSChaos** - For AWS-specific chaos experiments
- **GCPChaos** - For Google Cloud Platform chaos experiments
- **DNSChaos** - For DNS resolution chaos experiments
- **Workflow** - For orchestrating complex multi-step chaos experiments

## Quick Start

### Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

### Installation

1. Add the Helm repository:
```bash
helm repo add kairoscloud https://kairoscloud.github.io/kairoscloud-charts/
helm repo update
```

2. Install the chart:
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart
```

### Local Development

To work with the chart locally:

```bash
# Clone the repository
git clone https://github.com/KairosCloud/kairoscloud-charts.git
cd kairoscloud-charts

# Install dependencies
helm dependency update charts/kairoscloud-chart

# Lint the chart
helm lint charts/kairoscloud-chart

# Test the chart
helm template my-kairoscloud charts/kairoscloud-chart

# Install locally
helm install my-kairoscloud ./charts/kairoscloud-chart
```

## Configuration

The chart supports extensive configuration through the `values.yaml` file. See the [chart documentation](./charts/kairoscloud-chart/README.md) for detailed configuration options.

## Examples

### Basic Deployment
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set image.repository=myregistry/kairoscloud \
  --set image.tag=v1.0.0
```

### StatefulSet with Persistence
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set statefulset.enabled=true \
  --set persistence.enabled=true \
  --set persistence.size=20Gi
```

### High Availability Setup
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set replicaCount=3 \
  --set podDisruptionBudget.enabled=true \
  --set autoscaling.enabled=true \
  --set autoscaling.minReplicas=3 \
  --set autoscaling.maxReplicas=10
```

## CI/CD

This repository includes GitHub Actions workflows for:

- **Linting and Testing** - Validates chart syntax and templates
- **Packaging** - Creates chart packages
- **Publishing** - Publishes charts to GitHub Pages
- **Release Management** - Handles chart releases

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes (`helm lint charts/kairoscloud-chart`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.