RELEASE_NAME := vm-benchmark
NAMESPACE := default # k8s namespace for installing the chart

# print resulting manifests to console without applying them
debug:
	helm install --dry-run --debug $(RELEASE_NAME) .

# install the chart to configured namespace
install:
	helm upgrade -i $(RELEASE_NAME) -n $(NAMESPACE) .

# delete the chart from configured namespace
delete:
	helm uninstall $(RELEASE_NAME) -n $(NAMESPACE)

upgrade:
	helm upgrade $(RELEASE_NAME) -n $(NAMESPACE) .

list:
	kubectl get all -n $(NAMESPACE)

list-all:
	kubectl get all,pvc,cm -n $(NAMESPACE)

re-install: delete install
