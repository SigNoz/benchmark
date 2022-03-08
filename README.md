# signoz-benchmark

1. Create `benchmark` namespace.

```bash
cd manifests

kubectl create ns benchmark
```

2. Create Node-Exporter resources:

```bash
kubectl apply -n benchmark -f node-exporter/
```

3. Create Otel-Collector resources:

```bash
kubectl apply -n benchmark -f manifests/otel-collector
```
