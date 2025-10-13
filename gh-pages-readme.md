# KairosCloud Helm Charts

This repository contains Helm charts for deploying KairosCloud applications on Kubernetes.

## Usage

[Helm](https://helm.sh) must be installed to use the charts. Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```bash
helm repo add kairoscloud https://kairoscloud.github.io/kairoscloud-charts
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages. You can then run `helm search repo
kairoscloud` to see the charts.

To install the kairoscloud-chart chart:

```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart
```

To uninstall the chart:

```bash
helm uninstall my-kairoscloud
```

## Charts

### kairoscloud-chart

A comprehensive Helm chart that supports deploying KairosCloud applications with the following Kubernetes resources:

- **Deployment** - For stateless applications
- **StatefulSet** - For stateful applications with persistent storage
- **Service** - For exposing applications within the cluster
- **PersistentVolumeClaim** - For persistent storage
- **ConfigMap** - For configuration data
- **Secret** - For sensitive data management
- **PodDisruptionBudget** - For high availability during disruptions
- **ServiceAccount** - For RBAC
- **Role & RoleBinding** - For fine-grained permissions
- **NetworkPolicy** - For network security
- **HorizontalPodAutoscaler** - For automatic scaling
- **Ingress** - For external access
- **ServiceMonitor** - For Prometheus monitoring
- **Certificate** - For TLS management
- **VolumeSnapshot** - For backup operations
- **CronJob** - For scheduled tasks
- **Job** - For batch processing
- **LimitRange** - For resource limits
- **ResourceQuota** - For resource quotas

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

### Production Setup with Security
```bash
helm install my-kairoscloud kairoscloud/kairoscloud-chart \
  --set networkPolicy.enabled=true \
  --set rbac.enabled=true \
  --set secret.enabled=true \
  --set certificate.enabled=true \
  --set serviceMonitor.enabled=true
```

## Configuration

The chart supports extensive configuration through the `values.yaml` file. See the [chart documentation](https://github.com/KairosCloud/kairoscloud-charts/tree/main/charts/kairoscloud-chart) for detailed configuration options.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes (`helm lint charts/kairoscloud-chart`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## License

This project is licensed under the MIT License.
