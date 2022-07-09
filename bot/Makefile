.PHONY: 

help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run-locally-single: ## Running Locally - Single Node
	iex -S mix

RANDOM ?= `head -128 /dev/urandom | cksum | cut -d ' ' -f1`j
run-locally-multinode: ## Running Locally - MultiNode
	ERL_FLAGS="-name bot$(RANDOM)@127.0.0.1 -setcookie cookie" iex -S mix

