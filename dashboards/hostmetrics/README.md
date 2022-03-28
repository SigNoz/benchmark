# HostMetrics Dashboard

The Host Metrics dashboard consists of combination of charts that would help to monitor metrics of the instances.


## Import using Script

You can use the following command to import the dashboard:

```bash
curl -sL https://github.com/SigNoz/benchmark/raw/main/dashboards/hostmetrics/hostmetrics-import.sh \
    | SIGNOZ_ENDPOINT="http://localhost:3301" HOSTNAME="test-instance-1" DASHBOARD_TITLE="HostMetrics Dashboard for test-instance-1" bash
```

Alternatively, you can use the clone the repository and run the script:

```bash
git clone https://github.com/SigNoz/benchmark.git

cd dashboards/hostmetrics

cat hostmetrics-import.sh \
    | SIGNOZ_ENDPOINT="https://monitor.mysite.com:3301" HOSTNAME="test-instance-2" DASHBOARD_TITLE="HostMetrics Dashboard for test-instance-2" bash
```

_*Notes:_
- Set `SIGNOZ_ENDPOINT` variable to point to SigNoz frontend endpoint.
- In case `HOSTNAME` variable is skipped, it will select the current machine hostname using the default shell variable `HOSTNAME`.
- If `DASHBOARD_TITLE` variable is skipped, it will create title with the template: `HostMetrics Dashboard for <hostname>`.
- Dashboard uuid is randomly generated. You can pass `DASHBOARD_UUID` variable to override.
- To skip the hostname label filter from all charts, set the `HOSTNAME` variable to an empty string `""`.
