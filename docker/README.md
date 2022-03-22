# HostMetrics to SigNoz OTLP

The Host Metrics receiver generates metrics about the host system scraped from various sources. This is intended to be used when the collector is deployed as an agent.

It is supported for `metrics` type pipeline.****

## Configuration

Using `hostmetrics` receiver to scrape node metrics.

```yaml
receivers:
  hostmetrics:
    collection_interval: 1m
    scrapers:
      cpu:
      memory:
      load:
      network:
      disk:
      filesystem:
```

Using `resourcedetection` processor to detect host resource information and \
appending/overiding the resource value in telemetry data.

```yaml
processors:
  resourcedetection/env:
    detectors: [env, system] # include ec2 for AWS, gce for GCP and azure for Azure.
    # Using OTEL_RESOURCE_ATTRIBUTES envvar, env detector adds custom labels.
    timeout: 2s
    override: false
    system:
      hostname_sources: [os] # alternatively, use [dns,os] for setting FQDN as host.name and os as fallback
```

_*Note: In case of Docker Swarm, using only `env` detector._

## Deploy

We can set up hostmetric collector using OpenTelemetry Collector Binary, Docker Standalone and Docker Swarm.

### Binary

Follow the steps below for OpenTelemetry Collector Binary:

```bash
# download linux amd64 deb file
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.43.0/otelcol-contrib_0.43.0_linux_amd64.deb

# install otelcol using dpkg
sudo dpkg -i otelcol-contrib_0.43.0_linux_amd64.deb

# wget standalone config
wget https://github.com/SigNoz/benchmark/raw/main/docker/standalone/config.yaml

# replace <IP of machine hosting SigNoz> with SigNoz Otel IP
vim config.yaml

# copy the config yaml to otelcol-contrib config folder
sudo cp config.yaml /etc/otelcol-contrib/config.yaml

# restart otel with updated config
sudo systemctl restart otelcol

# view logs
sudo journalctl -u otelcol
```

### Docker Standalone

Follow the steps below for Docker Standalone:

```bash
# clone the repo
git clone https://github.com/SigNoz/benchmark.git

# change directory
cd benchmark/docker/standalone

# replace <IP of machine hosting SigNoz> with SigNoz Otel IP
vim config.yaml

# bring up otel collector
docker-compose up -d
```

### Docker Swarm

Follow the steps below for Docker Swarm:

```bash
# clone the repo
git clone https://github.com/SigNoz/benchmark.git

# change directory
cd benchmark/docker/swarm

# replace <IP of machine hosting SigNoz> with SigNoz Otel IP
vim config.yaml

# bring up otel collector
docker stack deploy -c docker-compose.swarm.yaml hostmetrics
```

### List of Metrics from HostMetrics Receiver

```console
system_cpu_time
system_cpu_load_average_1m
system_cpu_load_average_5m
system_cpu_load_average_15m
system_disk_io
system_disk_io_time
system_disk_operations
system_disk_operation_time
system_disk_pending_operations
system_filesystem_usage
system_memory_usage
system_network_connections
system_network_dropped
system_network_errors
system_network_io
system_network_packets
```

## License

MIT License

Copyright (c) 2022 SigNoz
