SHELL := /bin/bash
# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

# k3d section
cluster-create: ## Create dev cluster
	@k3d cluster create dev --port 15672:15672@loadbalancer --port 5672:5672@loadbalancer --port 5432:5432@loadbalancer --servers 2 --servers-memory 6G

cluster-delete: ## Delete dev cluster
	@k3d cluster delete dev

cluster-start: ## Start dev cluster
	@k3d cluster start dev

cluster-stop: ## Stop dev cluster
	@k3d cluster stop dev

# Rabbitmq section
rabbitmq-install-operator: ## Install rabbitmq cluster operator
	@kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml" > /dev/null
	./scripts/helpers/resource-checks.sh rabbitmq-operator

rabbitmq-delete-operator: ## Delete rabbitmq cluster operator
	@kubectl delete -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml" > /dev/null

rabbitmq-install-cluster: ## Create rabbitmq cluster
	@kubectl apply -f ./manifests/rabbitmq/rabbitmq-cluster.yaml > /dev/null
	./scripts/helpers/resource-checks.sh rabbitmq-cluster

rabbitmq-delete-cluster: ## Delete rabbitmq cluster
	@kubectl delete -f ./manifests/rabbitmq/rabbitmq-cluster.yaml > /dev/null

# global section
up: cluster-create rabbitmq-install-operator  rabbitmq-install-cluster ## Run cluster rabbitmq-install-operator rabbitmq-install-cluster

down: cluster-delete ## Delete cluster

start: cluster-start ## Start dev cluster

stop: cluster-stop ## Stop dev cluster