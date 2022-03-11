RELEASE_NAME := vm-benchmark
NAMESPACE := default # k8s namespace for installing the chart

# print resulting manifests to console without applying them
debug:
	helm install --dry-run --debug $(RELEASE_NAME) charts/metrics-benchmark

# install the chart to configured namespace
install:
	helm upgrade -i $(RELEASE_NAME) -n $(NAMESPACE) charts/metrics-benchmark

# delete the chart from configured namespace
delete:
	helm uninstall $(RELEASE_NAME) -n $(NAMESPACE)

upgrade:
	helm upgrade $(RELEASE_NAME) -n $(NAMESPACE)

re-install: delete install