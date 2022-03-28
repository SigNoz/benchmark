#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")";

# Set the hostname filter if hostname is passed
if [[ -z $HOSTNAME ]]; then
    HOSTNAME_FILTER="host_name=\"${HOST_NAME}\""
    HOSTNAME_FILTER_COMMA="${HOSTNAME_FILTER},"
else
    HOST_NAME="ALL"
fi

# Set Dashboard UUID
if [[ -z $DASHBOARD_UUID ]]; then
    DASHBOARD_UUID="$(uuidgen || cat /proc/sys/kernel/random/uuid)"
fi

# Set Dashboard Title
if [[ -z $DASHBOARD_TITLE ]]; then
    DASHBOARD_TITLE="HostMetrics Dashboard - $HOST_NAME"
fi

# Setup sample apps into specified namespace
(cat hostmetrics-template.json 2>/dev/null || curl -sL https://github.com/SigNoz/benchmark/raw/main/dashboards/hostmetrics/hostmetrics-template.json) | \
    DASHBOARD_UUID="${DASHBOARD_UUID}" \
    DASHBOARD_TITLE="${DASHBOARD_TITLE}" \
    HOSTNAME_FILTER="${HOSTNAME_FILTER}" \
    HOSTNAME_FILTER_COMMA="${HOSTNAME_FILTER_COMMA}" \
    envsubst | curl --fail --silent --output /dev/null --show-error --location --request POST \
    --header 'Accept: application/json, text/plain, */*' \
    --header 'Content-Type: application/json' \
    --data-binary @- 'http://localhost:3301/api/v1/dashboards'

if [ $? -ne 0 ]; then
    echo "❌ Failed to import Host Metrics dashboard"
else
    echo "✅ Succesfully imported Host Metrics dashboard"
fi
