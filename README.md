# Benchmark

This repository consists of kubernetes manifests for `otel-collector` and `node-exporter`.
These manifests can be used to generate `time-series` data in SigNoz cluster.
We can plot graphs in the **Dashboard** from SigNoz UI.

## Using Helm

1. Change directory to `charts/metrics-benchmark`:
```bash
cd charts/metrics-benchmark
```

2. Use `Makefile` to `helm install`:
```bash
make install
```

## Example Manifests

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

# Alternatively for DaemonSet, cd to single-node-exporter
cd single-node-exporter
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
