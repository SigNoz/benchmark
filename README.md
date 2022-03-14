# Benchmark

This repository consists of kubernetes manifests for `otel-collector` and `node-exporter`.
These manifests can be used to generate `time-series` data in SigNoz cluster.
We can plot graphs in the **Dashboard** from SigNoz UI.

## Using Helm

The `metrics-benchmark` helm chart uses single `Node-Exporter` alongside `Nginx` for cache.
It deploys `Otel-Collector` which scrapes data simulated hosts with unique host labels.

1. Change directory to `charts/metrics-benchmark`:
```bash
cd charts/metrics-benchmark
```

2. Use `Makefile` to `helm install`:
```bash
make install
```

_*Note: In case of SigNoz cluster running in different cluster, replace `my-release-clickhouse.platform.svc.cluster.local` in `values.yaml` with appropriate accessible address._

## Example Manifests

We have two types of manifests:
- Single-Node-Expoter: runs single instance of `Node-Exporter` and `Otel-Collector` as `Deployment`.
- Multiple-Node-Expoters: runs multiple instance of `Node-Exporter` as `DaemonSet` and `Otel-Collector` as `Deployment`.

1. Create `benchmark` namespace:
```bash
kubectl create ns benchmark
```

2. Change directory to `manifests`:
```bash
cd manifests
```

3. You can either create `Node-Exporter` as `Deployment` or `DaemonSet`:
```bash
# For Deployment, cd to single-node-exporter
cd single-node-exporter

# Alternatively for DaemonSet, cd to multiple-node-exporters
cd multiple-node-exporters
```

4. Create `Node-Exporter` resources:
```bash
kubectl apply -n benchmark -f node-exporter/
```

5. Create `Otel-Collector` resources:
```bash
kubectl apply -n benchmark -f otel-collector/
```

_*Note: In case of SigNoz cluster running in different cluster, replace `my-release-clickhouse.platform.svc.cluster.local` in `otel-collector/config.yaml` with appropriate accessible address._

## License

MIT License

Copyright (c) 2022 SigNoz
