# Contributing to KairosCloud Helm Charts

This document outlines the development workflow and quality assurance processes for the KairosCloud Helm Charts repository.

## 🚀 Quick Start

### Prerequisites

- **Helm 3.12.0+**: [Install Helm](https://helm.sh/docs/intro/install/)
- **kubectl**: [Install kubectl](https://kubernetes.io/docs/tasks/tools/)
- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Pre-commit** (optional): `pip install pre-commit`

### Local Development Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/KairosCloud/kairoscloud-charts.git
   cd kairoscloud-charts
   ```

2. **Install pre-commit hooks** (recommended):
   ```bash
   pre-commit install
   ```

3. **Install helm-unittest plugin**:
   ```bash
   helm plugin install https://github.com/helm-unittest/helm-unittest.git
   ```

## 🔍 Quality Assurance

### Automated Testing

Our CI/CD pipeline runs the following checks on every commit and pull request:

#### 1. **Helm Lint** (`helm lint`)
- Validates chart syntax and structure
- Checks for best practices
- Runs with `--strict` mode for enhanced validation

#### 2. **Helm Unit Tests** (`helm unittest`)
- Tests all chart templates with various scenarios
- Validates template rendering
- Ensures proper conditional logic
- Runs with `--color` and `--strict` flags

#### 3. **Template Validation**
- Tests template rendering with multiple scenarios:
  - **Default**: Basic configuration
  - **StatefulSet**: StatefulSet with persistence
  - **Autoscaling**: HPA configuration
  - **Security**: NetworkPolicy, RBAC, Secrets
  - **Monitoring**: ServiceMonitor, Certificates, Ingress
  - **Istio**: All Istio resources enabled
  - **KEDA**: Event-driven autoscaling
  - **Production**: Full production configuration

#### 4. **Dry Run Validation** (`helm install --dry-run`)
- Simulates chart installation
- Validates all Kubernetes resources
- Checks for configuration conflicts

#### 5. **Chart Packaging**
- Creates and validates chart packages
- Tests package integrity
- Verifies all required files are included

### Local Testing

Run these commands locally before committing:

```bash
# 1. Lint all charts
for chart in charts/*/; do
  if [ -f "$chart/Chart.yaml" ]; then
    echo "Linting $chart"
    helm lint "$chart" --strict
  fi
done

# 2. Run unit tests
for chart in charts/*/; do
  if [ -f "$chart/Chart.yaml" ]; then
    echo "Testing $chart"
    helm unittest "$chart" --color --strict
  fi
done

# 3. Test template rendering
helm template test-release charts/kairoscloud-chart --debug

# 4. Test dry run
helm install test-release charts/kairoscloud-chart --dry-run --debug
```

### Pre-commit Hooks

The repository includes pre-commit hooks that automatically run:

- **YAML formatting** and validation
- **Helm lint** on all charts
- **Helm unit tests** on all charts
- **Security scanning** for secrets
- **Markdown formatting**
- **Shell script validation**

## 📋 Development Workflow

### 1. **Branch Strategy**

- **`main`**: Production-ready code
- **`develop`**: Integration branch for features
- **`feature/*`**: Feature development branches
- **`bugfix/*`**: Bug fix branches
- **`hotfix/*`**: Critical production fixes

### 2. **Commit Process**

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** and test locally:
   ```bash
   # Run pre-commit hooks
   pre-commit run --all-files
   
   # Or run individual tests
   helm lint charts/kairoscloud-chart --strict
   helm unittest charts/kairoscloud-chart --color --strict
   ```

3. **Commit with conventional commits**:
   ```bash
   git commit -m "feat: add new Istio VirtualService template"
   git commit -m "fix: correct selector logic in AuthorizationPolicy"
   git commit -m "test: add unit tests for Gateway resource"
   ```

4. **Push and create a Pull Request**:
   ```bash
   git push origin feature/your-feature-name
   ```

### 3. **Pull Request Process**

1. **All CI checks must pass**:
   - ✅ Helm Lint
   - ✅ Helm Unit Tests
   - ✅ Template Validation (all scenarios)
   - ✅ Dry Run Validation
   - ✅ Chart Packaging

2. **Code review requirements**:
   - At least one approval from maintainers
   - All conversations resolved
   - Up-to-date with target branch

3. **Merge requirements**:
   - Squash and merge for feature branches
   - Merge commit for release branches

## 🧪 Testing Guidelines

### Unit Test Best Practices

1. **Test Structure**:
   ```yaml
   suite: resource-name
   templates:
     - template.yaml
   tests:
     - it: should create resource with basic configuration
       set:
         resource.enabled: true
       asserts:
         - isKind:
             of: ResourceType
         - equal:
             path: metadata.name
             value: RELEASE-NAME-chart-name
   ```

2. **Test Scenarios**:
   - ✅ Basic configuration
   - ✅ Custom values
   - ✅ Conditional rendering
   - ✅ Edge cases
   - ✅ Error conditions

3. **Assertion Types**:
   - `isKind`: Verify resource type
   - `equal`: Check exact values
   - `contains`: Check array contents
   - `isNull`: Verify no rendering

### Template Testing

Test your templates with various scenarios:

```bash
# Default configuration
helm template test charts/kairoscloud-chart

# With Istio enabled
helm template test charts/kairoscloud-chart \
  --set istio.enabled=true \
  --set istio.virtualService.enabled=true

# Production configuration
helm template test charts/kairoscloud-chart \
  --set replicaCount=3 \
  --set autoscaling.enabled=true \
  --set networkPolicy.enabled=true
```

## 📚 Chart Development

### Adding New Resources

1. **Create the template** in `charts/kairoscloud-chart/templates/`
2. **Add configuration** to `values.yaml`
3. **Create unit tests** in `charts/kairoscloud-chart/tests/`
4. **Update documentation** in `README.md`
5. **Test all scenarios** locally

### Template Best Practices

1. **Use conditional rendering**:
   ```yaml
   {{- if .Values.resource.enabled }}
   apiVersion: v1
   kind: Resource
   {{- end }}
   ```

2. **Include proper labels**:
   ```yaml
   labels:
     {{- include "chart-name.labels" . | nindent 4 }}
   ```

3. **Use helpers for names**:
   ```yaml
   name: {{ include "chart-name.fullname" . }}
   ```

4. **Handle empty values gracefully**:
   ```yaml
   {{- with .Values.resource.annotations }}
   annotations:
     {{- toYaml . | nindent 4 }}
   {{- end }}
   ```

## 🔧 Troubleshooting

### Common Issues

1. **Lint failures**:
   - Check YAML syntax
   - Verify required fields in Chart.yaml
   - Ensure proper indentation

2. **Unit test failures**:
   - Verify test assertions match template output
   - Check conditional logic in templates
   - Ensure proper test data setup

3. **Template rendering errors**:
   - Check Helm template syntax
   - Verify values.yaml structure
   - Test with `--debug` flag

### Getting Help

- **Issues**: Create a GitHub issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check the chart README.md files

## 📈 Performance

### CI/CD Optimization

- **Parallel execution**: Tests run in parallel when possible
- **Caching**: Helm plugins and dependencies are cached
- **Fast feedback**: Lint and unit tests run first
- **Matrix testing**: Multiple scenarios tested efficiently

### Local Development

- **Pre-commit hooks**: Catch issues early
- **Incremental testing**: Test only changed charts
- **Local validation**: Full test suite before pushing

## 🎯 Success Criteria

A successful contribution should:

- ✅ Pass all CI/CD checks
- ✅ Include comprehensive unit tests
- ✅ Follow Helm best practices
- ✅ Update documentation
- ✅ Maintain backward compatibility
- ✅ Include proper error handling

---

**Happy contributing! 🚀**
