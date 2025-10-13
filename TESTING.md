# Helm Chart Testing Guide

This document describes the comprehensive testing approach for the KairosCloud Helm charts.

## Testing Strategy

Our testing strategy includes multiple layers of validation to ensure chart quality and reliability:

### 1. **Unit Tests (helm-unittest)**
- **BDD-style Testing**: Behavior-driven development tests for Helm templates
- **Template Validation**: Tests individual template rendering with various inputs
- **Assertion-based**: Validates specific fields, values, and resource properties
- **Snapshot Testing**: Ensures templates don't change unexpectedly
- **Comprehensive Coverage**: Tests all major chart templates and configurations

### 2. **Linting Tests**
- **Helm Lint**: Validates chart syntax and best practices
- **Chart Structure**: Ensures required files and fields are present
- **Dependencies**: Validates chart dependencies are properly configured

### 3. **Template Rendering Tests**
- **Default Configuration**: Tests chart with default values
- **Multiple Scenarios**: Tests various configuration combinations
- **Edge Cases**: Tests boundary conditions and optional features

### 4. **Dry Run Tests**
- **Installation Simulation**: Simulates chart installation without actually deploying
- **Validation**: Ensures all resources can be created successfully

### 5. **Package Tests**
- **Chart Packaging**: Validates chart can be packaged correctly
- **Package Integrity**: Ensures packaged chart is valid and complete

## Test Scenarios

### Default Configuration
Tests the chart with minimal configuration to ensure it works out-of-the-box.

### StatefulSet Configuration
Tests the chart with StatefulSet enabled and persistent storage configured.

### Autoscaling Configuration
Tests horizontal pod autoscaling with various replica counts and scaling policies.

### Security Configuration
Tests security features including:
- NetworkPolicy for network isolation
- RBAC for access control
- Secrets for sensitive data
- Security contexts for pod security

### Monitoring Configuration
Tests observability features including:
- ServiceMonitor for Prometheus metrics
- Certificate management for TLS
- Ingress configuration for external access

### Production Configuration
Tests a complete production-ready setup with:
- High availability (multiple replicas, PDB)
- Autoscaling
- Security policies
- Monitoring
- Persistent storage
- Resource limits

## Running Tests

### Local Testing

1. **Install helm-unittest plugin:**
   ```bash
   helm plugin install https://github.com/helm-unittest/helm-unittest.git
   ```

2. **Run the test runner script:**
   ```bash
   cd charts/kairoscloud-chart/tests
   ./test-runner.sh
   ```

3. **Run helm-unittest directly:**
   ```bash
   # Run all unit tests
   helm unittest charts/kairoscloud-chart
   
   # Run with color output
   helm unittest charts/kairoscloud-chart --color
   
   # Run specific test file
   helm unittest charts/kairoscloud-chart -f tests/deployment_test.yaml
   
   # Update snapshots
   helm unittest charts/kairoscloud-chart --update-snapshot
   ```

4. **Run individual test scenarios:**
   ```bash
   # Test default configuration
   helm template kairoscloud-chart ../charts/kairoscloud-chart
   
   # Test with custom values
   helm template kairoscloud-chart ../charts/kairoscloud-chart \
     --values tests/test-values.yaml
   
   # Test specific scenario
   helm template kairoscloud-chart ../charts/kairoscloud-chart \
     --set statefulset.enabled=true \
     --set persistence.enabled=true
   ```

5. **Run linting:**
   ```bash
   helm lint charts/kairoscloud-chart
   ```

6. **Run dry-run test:**
   ```bash
   helm install kairoscloud-chart charts/kairoscloud-chart \
     --dry-run --debug
   ```

### CI/CD Testing

Tests are automatically run in GitHub Actions:

- **Pull Request Tests**: Comprehensive testing on every PR including unit tests
- **Release Tests**: Full validation before chart release including helm-unittest
- **Matrix Testing**: Multiple scenarios tested in parallel
- **Unit Test Job**: Dedicated job for helm-unittest plugin testing

## Test Files

### Unit Test Files
- **`deployment_test.yaml`**: Unit tests for Deployment template
- **`statefulset_test.yaml`**: Unit tests for StatefulSet template
- **`service_test.yaml`**: Unit tests for Service template
- **`configmap_test.yaml`**: Unit tests for ConfigMap template
- **`secret_test.yaml`**: Unit tests for Secret template
- **`networkpolicy_test.yaml`**: Unit tests for NetworkPolicy template
- **`snapshot_test.yaml`**: Snapshot tests for critical templates

### Test Configuration Files
- **`test-values.yaml`**: Comprehensive test values covering all chart features and configurations
- **`test-runner.sh`**: Automated test runner that executes all test scenarios and validations

### GitHub Workflows
- **`.github/workflows/test.yml`**: PR testing with matrix scenarios and unit tests
- **`.github/workflows/helm-chart.yml`**: Release testing and publishing with helm-unittest

## Test Matrix

| Scenario | Description | Key Features Tested |
|----------|-------------|-------------------|
| `default` | Basic configuration | Core functionality |
| `statefulset` | Stateful workload | Persistent storage, StatefulSet |
| `autoscaling` | Scaling configuration | HPA, replica management |
| `security` | Security features | NetworkPolicy, RBAC, Secrets |
| `monitoring` | Observability | ServiceMonitor, Certificates |
| `production` | Production setup | All features combined |

## Validation Checklist

Before releasing a chart version, ensure:

- [ ] All linting tests pass
- [ ] All template rendering tests pass
- [ ] All dry-run tests pass
- [ ] Chart packages successfully
- [ ] Package integrity is validated
- [ ] Documentation is updated
- [ ] Version is incremented in Chart.yaml
- [ ] Changelog is updated

## Troubleshooting

### Common Issues

1. **Template Rendering Errors**
   - Check YAML syntax in templates
   - Validate template functions and pipelines
   - Ensure all required values are provided

2. **Linting Failures**
   - Fix chart metadata issues
   - Resolve dependency problems
   - Address best practice violations

3. **Package Issues**
   - Verify Chart.yaml format
   - Check file permissions
   - Ensure all required files are present

### Debug Commands

```bash
# Debug template rendering
helm template kairoscloud-chart charts/kairoscloud-chart --debug

# Check chart structure
helm show chart charts/kairoscloud-chart

# Validate dependencies
helm dependency list charts/kairoscloud-chart
helm dependency update charts/kairoscloud-chart
```

## Helm-unittest Best Practices

### Writing Unit Tests
1. **Use descriptive test names** that clearly indicate what is being tested
2. **Test both positive and negative cases** (enabled/disabled features)
3. **Use assertions that validate specific fields** rather than just checking if resources exist
4. **Test with different value combinations** to ensure flexibility
5. **Use snapshot tests sparingly** and only for complex configurations
6. **Group related tests** in the same test file for better organization

### Test Structure
```yaml
suite: deployment
templates:
  - deployment.yaml
tests:
  - it: should create deployment with default values
    asserts:
      - isKind:
          of: Deployment
      - equal:
          path: metadata.name
          value: kairoscloud-chart
```

### Snapshot Testing
- Use for complex configurations that are hard to assert individually
- Always review snapshot changes before updating
- Use regex patterns to validate specific parts of snapshots
- Keep snapshots focused on critical functionality

### Assertion Types
- **`isKind`**: Validates resource type
- **`equal`**: Validates exact field values
- **`contains`**: Validates array/list contents
- **`isNotNull`**: Validates field existence
- **`isNull`**: Validates field absence
- **`matchSnapshot`**: Validates against cached snapshots

## Best Practices

1. **Always test locally** before pushing changes
2. **Use meaningful test scenarios** that reflect real-world usage
3. **Keep test values up-to-date** with chart changes
4. **Document test scenarios** for team understanding
5. **Automate testing** in CI/CD pipelines
6. **Test edge cases** and error conditions
7. **Validate security configurations** thoroughly
8. **Write comprehensive unit tests** for all templates
9. **Use snapshot tests** for complex configurations
10. **Review test failures carefully** to understand root causes

## Contributing

When adding new features to the chart:

1. Add corresponding unit tests for new templates
2. Add test scenarios for new configuration options
3. Update test-values.yaml with new configurations
4. Add validation steps to test-runner.sh
5. Update snapshot tests if needed
6. Update this documentation
7. Ensure all tests pass before submitting PR
8. Run helm-unittest locally to validate new tests
