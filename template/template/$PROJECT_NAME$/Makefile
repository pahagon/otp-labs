.PHONY: 

APP_NAME ?= `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g' | sed -r 's/_([a-z])/-\1/gi'`
APP_VSN ?= `grep 'version:' mix.exs | cut -d '"' -f2`
BUILD ?= `git rev-parse --short HEAD`

help:
	@echo "$(APP_NAME):$(APP_VSN)-$(BUILD)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run-locally-single: ## Running Locally - Single Node
	iex -S mix

RANDOM ?= `head -128 /dev/urandom | cksum | cut -d ' ' -f1`j
run-locally-multinode: ## Running Locally - MultiNode
	ERL_FLAGS="-name $(APP_NAME)-$(RANDOM)@127.0.0.1 -setcookie cookie" iex -S mix

build: ## Build the Docker image
	docker build --force-rm --network=host \
	-t $(APP_NAME):$(APP_VSN)-$(BUILD) \
	-t $(APP_NAME):latest .

build-clean: ## Delete docker image
	docker image rm $(APP_NAME):$(APP_VSN)-$(BUILD) $(APP_NAME):latest

run-docker: ## Run the app in Docker
	docker run  \
	--expose 4000 -p 4000:4000 \
	--rm -it $(APP_NAME):latest

minikube-load-image: ## Deploy the charts in minikube
	eval $(minikube -p minikube docker-env) && \
	minikube image load $(APP_NAME):latest && \
	minikube image load $(APP_NAME):$(APP_VSN)-$(BUILD) && \
	minikube cache reload

kubectl-create: ## Create deployment and service
	kubectl create -f k8s/service-headless.yml && \
	kubectl create -f k8s/deployment.yml

kubectl-clean: ## Delete docker image
	kubectl delete deployments $(APP_NAME)-deployment && \
	kubectl delete service $(APP_NAME)-svc-headless && \
	kubectl delete pod -l app=$(APP_NAME)
