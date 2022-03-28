# HostMetrics Dashboard

The Host Metrics dashboard consists of combination of charts that would help to monitor metrics of the instances.


## Import using Script

You can use the following command to import the dashboard:

```bash
curl -sL https://github.com/SigNoz/benchmark/raw/main/dashboards/hostmetrics/hostmetrics-import.sh \
    | HOSTNAME="test-instance" DASHBOARD_TITLE="HostMetrics Dashboard for test-instance" bash
```

Alternatively, you can use the clone the repository and run the script:

```bash
git clone https://github.com/SigNoz/benchmark.git

cd dashboards/hostmetrics

cat hostmetrics-import.sh \
    | HOSTNAME="test-instance" DASHBOARD_TITLE="HostMetrics Dashboard for test-instance" bash
```

_*Notes:_
- In case `HOSTNAME` variable is skipped, it will skip the hostname label filter from all charts.
- If `DASHBOARD_TITLE` variable is skipped, it will create title with the template: `HostMetrics Dashboard for <hostname>`.
- Dashboard uuid is randomly generated. You can pass `DASHBOARD_UUID` variable to override.
