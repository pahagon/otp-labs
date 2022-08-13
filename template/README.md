# Project that ties otp, kubernetes, libcluster and hord
This project is an elixir project generator for all projects in otp-labs. 
It tries to save a couple of your minutes tidying configuration and dependency.

This OTP template project generates:
    * Libcluster configuration:
      * You can choose libcluster strategy(gossip or local epmd) from environment var.
    * Elixir Release configuration:
      * Project sname configured with pattern  @release.name@POD_A_RECORD.$NAMESPACE.pod.cluster.local.
    * Dockerfile:
      * There is Dockerfile that describe a recipe to create a app using linux alphine.
    * Deployment and services k8s:
      * Deployment file that:
        * Exports pod_ip, namespace and cluster_strategy (default: gossip).
        * Exports epmd port.
      * Service file that:
        * Create a cluster.
        * Export empd port to all nodes.
    * Elixir Application that starts with:
      * Libcluster Supervisor.
      * Horde Subervisor and Registry.
      * NodeObserver in order to Horde Supervisor and Registry when nodes joint and leave the cluster.
      * "Empty" GenServer
    * Makefile with tasks:
      * run locally single-node
      * run locally multinode
      * build docker image
      * run locally on docker
      * load docker image to minikube
      * create deployment and service on minikube
      * remove docker image from docker, remove deployment and services from minikube
      
This project uses template system created by [dave thomas](https://pragdave.me/blog/2017/04/18/elixir-project-generator.html).

## Installation
```shell
make clone_pragdave_repos install_template_system install_otp_libcluster_horde_template
```
