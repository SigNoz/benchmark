{{/*
Expand the name of the chart.
*/}}
{{- define "vm-benchmark.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vm-benchmark.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vm-benchmark.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for node-exporter
*/}}
{{- define "vm-benchmark.nodeExporter.labels" -}}
helm.sh/chart: {{ include "vm-benchmark.chart" . }}
{{ include "vm-benchmark.nodeExporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels for node-exporter
*/}}
{{- define "vm-benchmark.nodeExporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vm-benchmark.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: exporter
{{- end }}

{{/*
Common labels for prometheus
*/}}
{{- define "vm-benchmark.prometheus.labels" -}}
helm.sh/chart: {{ include "vm-benchmark.chart" . }}
{{ include "vm-benchmark.prometheus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for prometheus
*/}}
{{- define "vm-benchmark.prometheus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vm-benchmark.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: prometheus
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vm-benchmark.nginxCached" -}}
{{- $port := .Values.nodeExporter.hostPortCached | int }}
{{- printf "%s-exporter.%s.svc:%d" (include "vm-benchmark.fullname" .) .Release.Namespace $port }}
{{- end }}
