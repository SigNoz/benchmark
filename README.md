# benchmark

This repository consists of kubernetes manifests for `otel-collector` and `node-exporter`.
These manifests can be used to generate `time-series` data in SigNoz cluster.
We can plot graphs in the **Dashboard** from SigNoz UI.

## Get Started

1. Create `benchmark` namespace:
```bash
kubectl create ns benchmark
```

2. Change directory to `manifests` folder:
```bash
cd manifests
```

3. Create `Node-Exporter` resources:
```bash
kubectl apply -n benchmark -f node-exporter/
```

4. Create `Otel-Collector` resources:
```bash
kubectl apply -n benchmark -f manifests/otel-collector
```

_*Note: In case of SigNoz cluster running in different cluster, replace `my-release-clickhouse.platform.svc.cluster.local` in `manifests/otel-collector/config.yaml` with appropriate accessible address._

## License

MIT License

Copyright (c) 2022 SigNoz
