#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")";

# Set the hostname filter if hostname is passed
if [[ -z $HOSTNAME ]]; then
    HOSTNAME="ALL"
else
    HOSTNAME_FILTER='host_name=\"'${HOSTNAME}'\"'
    HOSTNAME_FILTER_COMMA="${HOSTNAME_FILTER},"
fi

# Set Dashboard UUID
if [[ -z $DASHBOARD_UUID ]]; then
    DASHBOARD_UUID="$(uuidgen || cat /proc/sys/kernel/random/uuid)"
fi

# Set Dashboard Title
if [[ -z $DASHBOARD_TITLE ]]; then
    DASHBOARD_TITLE="HostMetrics Dashboard - $HOSTNAME"
fi

(cat hostmetrics-template.json 2>/dev/null || curl -sL https://github.com/SigNoz/benchmark/raw/main/dashboards/hostmetrics/hostmetrics-template.json) | \
    DASHBOARD_UUID="${DASHBOARD_UUID}" \
    DASHBOARD_TITLE="${DASHBOARD_TITLE}" \
    HOSTNAME_FILTER="${HOSTNAME_FILTER}" \
    HOSTNAME_FILTER_COMMA="${HOSTNAME_FILTER_COMMA}" \
    envsubst > signoz-hostmetrics-${HOSTNAME}.json

if [ $? -ne 0 ]; then
    echo "❌ Failed to generate Host Metrics dashboard"
else
    echo "✅ Succesfully generated Host Metrics dashboard: signoz-hostmetrics-${HOSTNAME}.json"
fi