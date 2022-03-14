# Metrics benchmark

Metrics benchmark helm chart is used for deploying a simple
benchmark setup to k8s cluster for benchmarking read (node exporter)
and write (via `clickhouseexporter`) to ClickHouseDB.

The helm chart deploys three pods:
* nodeexporter + nginx (2 containers in one pod), where nodeexporter used as a metrics source
and nginx as cache-server to reduce pressure on nodeexporter;
* vmagent to scrape `nodeexporter` metrics and forward via `clickhouseexporter` to ClickHouseDB;

Please, check [values.yaml](values.yaml) for configuration params.

## How to run

Check [Makefile](Makefile) for make commands.

Please check the `NAMESPACE` and `RELEASE_NAME` variables in [Makefile](Makefile)
before applying any commands.

```bash
make install # to install the chart
make delete # to delete the chart
```

Please note `resources` section [values.yaml](values.yaml) and adjust it accordingly to 
configured workload. The most of resources are supposed to be consumed by vmagent
and nginx+nodeexporter pods.

## Monitoring

vmagent is configured to scrape and send its own metrics 
with job label `vmagent`. These metrics will be written to the
configured `.Values.vmagent.clickhouseEndpoint` destination i.e. ClickHouseDB.
Use [grafana dashboard](https://grafana.com/grafana/dashboards/12683)
to monitor vmagent's state.

## Articles

This chart is inspired from following:
- [Benchmarking Prometheus-compatible time series databases](https://victoriametrics.com/blog/remote-write-benchmark/)
- [VictoriaMetrics/prometheus-benchmark GitHub repository](https://github.com/VictoriaMetrics/prometheus-benchmark)
