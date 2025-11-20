[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kairoscloud)](https://artifacthub.io/packagkairoscloudes/search?repo=)

# KairosCloud Helm Chart

A Helm chart for deploying KairosCloud application on Kubernetes.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- KEDA 2.0+ (if using KEDA autoscaling)

## Installing the Chart

To install the chart with the release name `my-kairoscloud`:

```bash
helm install my-kairoscloud ./kairoscloud-chart
```

The command deploys KairosCloud on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-kairoscloud` deployment:

```bash
helm delete my-kairoscloud
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `nameOverride`            | String to partially override kairoscloud-chart.fullname template with a string (will prepend the release name) | `""` |
| `fullnameOverride`        | String to fully override kairoscloud-chart.fullname template with a string | `""` |

### Image parameters

| Name                | Description                                                                             | Value           |
| ------------------- | --------------------------------------------------------------------------------------- | --------------- |
| `image.repository`  | KairosCloud image repository                                                            | `nginx`         |
| `image.tag`         | KairosCloud image tag (immutable tags are recommended)                                 | `""`            |
| `image.pullPolicy`  | KairosCloud image pull policy                                                           | `IfNotPresent`  |

### Image pull secrets

| Name                        | Description                                                                             | Value   |
| --------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `imagePullSecrets`          | Specify docker-registry secret names as an array                                       | `[]`    |

### ServiceAccount parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`       | Specifies whether a ServiceAccount should be created                                   | `true`  |
| `serviceAccount.annotations`  | Annotations to add to the ServiceAccount                                               | `{}`    |
| `serviceAccount.name`         | The name of the ServiceAccount to use                                                  | `""`    |

### Pod parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `podAnnotations`              | Annotations to add to the pods                                                          | `{}`    |
| `podSecurityContext`          | Pod security context                                                                    | `{}`    |
| `securityContext`             | Container security context                                                              | `{}`    |

### Service parameters

| Name                          | Description                                                                             | Value       |
| ----------------------------- | --------------------------------------------------------------------------------------- | ----------- |
| `service.type`                | KairosCloud service type                                                                | `ClusterIP` |
| `service.port`                | KairosCloud service port                                                                | `80`        |
| `service.targetPort`          | KairosCloud service target port                                                         | `8080`      |
| `service.annotations`         | Annotations to add to the service                                                       | `{}`        |

### Ingress parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `ingress.enabled`             | Enable ingress record generation for KairosCloud                                        | `false` |
| `ingress.className`           | IngressClass that will be used to implement the Ingress                                | `""`    |
| `ingress.annotations`         | Additional annotations for the Ingress resource                                         | `{}`    |
| `ingress.hosts`               | An array of hosts to be covered with this ingress record                               | `[]`    |
| `ingress.tls`                 | TLS configuration for additional hostname(s) to be covered with this ingress record    | `[]`    |

### Resource parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `resources.limits`            | The resources limits for the KairosCloud containers                                     | `{}`    |
| `resources.requests`          | The requested resources for the KairosCloud containers                                  | `{}`    |

### Autoscaling parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `autoscaling.enabled`         | Enable Horizontal POD autoscaling for KairosCloud                                       | `false` |
| `autoscaling.minReplicas`     | Minimum number of KairosCloud replicas                                                 | `1`     |
| `autoscaling.maxReplicas`     | Maximum number of KairosCloud replicas                                                 | `100`   |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage                                                      | `80`    |

### KEDA (Kubernetes Event-Driven Autoscaling) parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `keda.enabled`                | Enable KEDA ScaledObject for event-driven autoscaling                                  | `false` |
| `keda.annotations`            | Annotations to add to the KEDA ScaledObject                                            | `{}`    |
| `keda.minReplicas`            | Minimum number of replicas (defaults to autoscaling.minReplicas if not set)           | `null`  |
| `keda.maxReplicas`            | Maximum number of replicas (defaults to autoscaling.maxReplicas if not set)           | `null`  |
| `keda.pollingInterval`        | Polling interval for metrics (e.g., "30s", "1m")                                       | `null`  |
| `keda.cooldownPeriod`         | Cooldown period for scaling down (e.g., "300s", "5m")                                  | `null`  |
| `keda.idleReplicaCount`       | Number of replicas to maintain when idle (defaults to 0)                               | `null`  |
| `keda.advanced`               | Advanced KEDA configuration (HPA behavior, etc.)                                       | `{}`    |
| `keda.triggers`               | Array of KEDA triggers for different scaling metrics                                   | `[]`    |
| `keda.fallback`               | Global fallback configuration for KEDA                                                 | `{}`    |

### StatefulSet parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `statefulset.enabled`         | Enable StatefulSet instead of Deployment                                               | `false` |
| `statefulset.serviceName`     | Service name for StatefulSet                                                            | `""`    |
| `statefulset.podManagementPolicy` | Pod management policy for StatefulSet                                              | `OrderedReady` |
| `statefulset.updateStrategy`  | Update strategy for StatefulSet                                                         | `{}`    |

### Persistence parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `persistence.enabled`         | Enable persistence using Persistent Volume Claims                                       | `false` |
| `persistence.storageClass`    | Persistent Volume storage class                                                         | `""`    |
| `persistence.accessMode`      | Persistent Volume access mode                                                           | `ReadWriteOnce` |
| `persistence.size`            | Persistent Volume size                                                                  | `8Gi`   |
| `persistence.annotations`     | Persistent Volume annotations                                                           | `{}`    |

### ConfigMap parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `configMap.enabled`           | Enable ConfigMap                                                                        | `true`  |
| `configMap.data`              | ConfigMap data                                                                          | `{}`    |

### PodDisruptionBudget parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `podDisruptionBudget.enabled` | Enable PodDisruptionBudget                                                              | `false` |
| `podDisruptionBudget.minAvailable` | Minimum number of pods that must be available during eviction                        | `1`     |
| `podDisruptionBudget.maxUnavailable` | Maximum number of pods that can be unavailable during eviction                     | `1`     |

### Node parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `nodeSelector`                | Node labels for pod assignment                                                          | `{}`    |
| `tolerations`                 | Tolerations for pod assignment                                                          | `[]`    |
| `affinity`                    | Affinity for pod assignment                                                             | `{}`    |

### Health check parameters

| Name                          | Description                                                                             | Value   |
| ----------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `livenessProbe.enabled`       | Enable liveness probe                                                                   | `true`  |
| `readinessProbe.enabled`      | Enable readiness probe                                                                  | `true`  |
| `startupProbe.enabled`        | Enable startup probe                                                                    | `false` |

## Examples

### Basic deployment

```bash
helm install my-kairoscloud ./kairoscloud-chart
```

### Deployment with custom values

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set image.repository=myregistry/kairoscloud \
  --set image.tag=v1.0.0 \
  --set replicaCount=3 \
  --set service.type=LoadBalancer
```

### StatefulSet with persistence

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set statefulset.enabled=true \
  --set persistence.enabled=true \
  --set persistence.size=20Gi
```

### Deployment with ingress

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=kairoscloud.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix
```

### Deployment with KEDA CPU-based autoscaling

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set keda.enabled=true \
  --set keda.minReplicas=2 \
  --set keda.maxReplicas=10 \
  --set keda.triggers[0].type=cpu \
  --set keda.triggers[0].metadata.type=Utilization \
  --set keda.triggers[0].metadata.value="70" \
  --set keda.triggers[0].metricType=Utilization
```

### Deployment with KEDA Prometheus-based autoscaling

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set keda.enabled=true \
  --set keda.minReplicas=1 \
  --set keda.maxReplicas=20 \
  --set keda.pollingInterval="30s" \
  --set keda.cooldownPeriod="300s" \
  --set keda.triggers[0].type=prometheus \
  --set keda.triggers[0].metadata.serverAddress=http://prometheus-server.monitoring.svc.cluster.local:80 \
  --set keda.triggers[0].metadata.metricName=http_requests_per_second \
  --set keda.triggers[0].metadata.threshold="100" \
  --set keda.triggers[0].metadata.query="sum(rate(http_requests_total[2m]))" \
  --set keda.triggers[0].metricType=AverageValue
```

### Deployment with KEDA Kafka-based autoscaling

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set keda.enabled=true \
  --set keda.minReplicas=1 \
  --set keda.maxReplicas=5 \
  --set keda.triggers[0].type=kafka \
  --set keda.triggers[0].metadata.bootstrapServers=kafka-server:9092 \
  --set keda.triggers[0].metadata.consumerGroup=my-group \
  --set keda.triggers[0].metadata.topic=my-topic \
  --set keda.triggers[0].metadata.lagThreshold="5" \
  --set keda.triggers[0].authenticationRef.name=kafka-auth \
  --set keda.triggers[0].authenticationRef.kind=Secret
```

### Deployment with KEDA multiple triggers

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set keda.enabled=true \
  --set keda.minReplicas=2 \
  --set keda.maxReplicas=15 \
  --set keda.triggers[0].type=cpu \
  --set keda.triggers[0].metadata.type=Utilization \
  --set keda.triggers[0].metadata.value="70" \
  --set keda.triggers[0].metricType=Utilization \
  --set keda.triggers[1].type=memory \
  --set keda.triggers[1].metadata.type=Utilization \
  --set keda.triggers[1].metadata.value="80" \
  --set keda.triggers[1].metricType=Utilization
```

### Deployment with KEDA advanced configuration

```bash
helm install my-kairoscloud ./kairoscloud-chart \
  --set keda.enabled=true \
  --set keda.minReplicas=1 \
  --set keda.maxReplicas=10 \
  --set keda.advanced.horizontalPodAutoscalerConfig.behavior.scaleDown.stabilizationWindowSeconds=300 \
  --set keda.advanced.horizontalPodAutoscalerConfig.behavior.scaleDown.policies[0].type=Percent \
  --set keda.advanced.horizontalPodAutoscalerConfig.behavior.scaleDown.policies[0].value=50 \
  --set keda.advanced.horizontalPodAutoscalerConfig.behavior.scaleDown.policies[0].periodSeconds=60 \
  --set keda.triggers[0].type=cpu \
  --set keda.triggers[0].metadata.type=Utilization \
  --set keda.triggers[0].metadata.value="70" \
  --set keda.triggers[0].metricType=Utilization
```

## KEDA Integration

This Helm chart supports KEDA (Kubernetes Event-Driven Autoscaling) for advanced autoscaling scenarios. KEDA allows you to scale your application based on various metrics and events, not just CPU and memory utilization.

### Supported KEDA Triggers

The chart supports all KEDA scalers. Here are some common examples:

#### CPU and Memory Triggers
- **CPU**: Scale based on CPU utilization
- **Memory**: Scale based on memory utilization

#### External Metrics Triggers
- **Prometheus**: Scale based on Prometheus metrics
- **HTTP**: Scale based on HTTP endpoint responses
- **External**: Scale based on external metrics

#### Message Queue Triggers
- **Kafka**: Scale based on Kafka topic lag
- **RabbitMQ**: Scale based on RabbitMQ queue length
- **Redis**: Scale based on Redis list length
- **AWS SQS**: Scale based on SQS queue length

#### Database Triggers
- **PostgreSQL**: Scale based on PostgreSQL connection count
- **MySQL**: Scale based on MySQL connection count
- **MongoDB**: Scale based on MongoDB connection count

#### Cloud Provider Triggers
- **AWS CloudWatch**: Scale based on CloudWatch metrics
- **Azure Monitor**: Scale based on Azure Monitor metrics
- **GCP Pub/Sub**: Scale based on Pub/Sub subscription

### KEDA Installation

Before using KEDA with this chart, ensure KEDA is installed in your cluster:

```bash
# Install KEDA using Helm
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
helm install keda kedacore/keda --namespace keda-system --create-namespace
```

### KEDA Configuration Examples

#### Using values.yaml file

Create a `keda-values.yaml` file:

```yaml
keda:
  enabled: true
  minReplicas: 1
  maxReplicas: 10
  pollingInterval: "30s"
  cooldownPeriod: "300s"
  triggers:
    - type: cpu
      metadata:
        type: Utilization
        value: "70"
      metricType: Utilization
    - type: prometheus
      metadata:
        serverAddress: http://prometheus-server.monitoring.svc.cluster.local:80
        metricName: http_requests_per_second
        threshold: '100'
        query: sum(rate(http_requests_total[2m]))
      metricType: AverageValue
```

Then install with:

```bash
helm install my-kairoscloud ./kairoscloud-chart -f keda-values.yaml
```

#### Advanced KEDA Configuration

For more complex scenarios, you can configure advanced HPA behavior:

```yaml
keda:
  enabled: true
  minReplicas: 1
  maxReplicas: 20
  advanced:
    horizontalPodAutoscalerConfig:
      behavior:
        scaleDown:
          stabilizationWindowSeconds: 300
          policies:
          - type: Percent
            value: 50
            periodSeconds: 60
        scaleUp:
          stabilizationWindowSeconds: 0
          policies:
          - type: Percent
            value: 100
            periodSeconds: 15
  triggers:
    - type: kafka
      metadata:
        bootstrapServers: kafka-server:9092
        consumerGroup: my-group
        topic: my-topic
        lagThreshold: '5'
      authenticationRef:
        name: kafka-auth
        kind: Secret
```

### Important Notes

1. **Mutual Exclusivity**: KEDA autoscaling and standard HPA autoscaling are mutually exclusive. When `keda.enabled=true`, the standard `autoscaling.enabled` is ignored.

2. **Replica Management**: When KEDA is enabled, the `replicaCount` value is ignored as KEDA manages the replica count based on the configured triggers.

3. **StatefulSet Support**: KEDA works with both Deployments and StatefulSets. The chart automatically detects the workload type and configures the ScaledObject accordingly.

4. **Authentication**: For triggers that require authentication (like Kafka, Redis, etc.), you need to create the appropriate Secret resources with authentication credentials.

5. **Fallback Configuration**: You can configure fallback behavior for when KEDA metrics are unavailable:

```yaml
keda:
  enabled: true
  fallback:
    failureThreshold: 3
    replicas: 1
  triggers:
    # ... your triggers
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This chart is licensed under the MIT License.
