# Prometheus benchmark
Prometheus benchmark helm chart is used for deploying a simple
benchmark setup to k8s cluster for benchmarking read (executing PromQL/MetricsQL queries)
and write (via [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) protocol)
path of Prometheus-compatible TSDBs. 
In VictoriaMetrics we use it to run tests against 
our cloud solution, compare performance and compression between releases.

The helm chart deploys three pods:
* nodeexporter + nginx (2 containers in one pod), where nodeexporter used as a metrics source
and nginx as cache-server to reduce pressure on nodeexporter;
* prometheus to scrape nodeexporter metrics and forward via remote-write to configured destinations;

Please, check [values.yaml](values.yaml) for configuration params.

## Articles

- [Benchmarking Prometheus-compatible time series databases](https://victoriametrics.com/blog/remote-write-benchmark/)
- [VictoriaMetrics/prometheus-benchmark GitHub repository](https://github.com/VictoriaMetrics/prometheus-benchmark)

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
configured `.Values.vmagent.url.remoteWrite` destination.
Use [grafana dashboard](https://grafana.com/grafana/dashboards/12683)
to monitor vmagent's state.

vmagent is not aware of `url.remoteWrite` VictoriaMetrics configuration 
or its components, so it can't scrape their metrics. Please, configure 
monitoring of `remoteWrite` destination manually by setting up an external monitoring 
or updating [configmap.yaml](templates/vmagent/configmap.yaml) with corresponding
targets. Use grafana dashboards for [single](https://grafana.com/grafana/dashboards/10229)
or [cluster](https://grafana.com/grafana/dashboards/11176) versions of VictoriaMetrics.
