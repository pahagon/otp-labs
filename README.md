# OTP Labs

OTP Labs is a demo application built with Elixir and OTP to show how to integrate
Distributed Elixir on Kubernetes with Horde and LibCluster.

This project ties up:

- Elixir Application with:
  - Libcluster Supervisor.
  - Horde Subervisor and Registry.
  - NodeObserver in order to Horde Supervisor and Registry add and remove nodes from cluster.
- Libcluster config:
  - You can choose libcluster strategy(gossip or local epmd) from environment var.
  - You can add more libcluster strategies.
- Dockerfile:
  - Create an app image using linux alphine.
- Kubernete Deployment and Service file:
  - Deployment file:
    - Creates pods with app image, exports pod_ip, namespace and cluster_strategy (default: gossip).
    - Exports epmd port.
  - Service file:
    - Creates a cluster.
    - Exports empd port to all nodes.
- Elixir Release config:
  - Project sname configured using the following pattern @release.name@POD_A_RECORD.$NAMESPACE.pod.cluster.local.
- Makefile with tasks:
  - Run locally single-node.
  - Run locally multi-node.
  - Build docker image.
  - Run locally on docker.
  - Load docker image on minikube.
  - Create deployment and service on minikube
  - Remove docker image from docker, remove deployment and services from minikube

## Setup local environment on Ubuntu

There is [ansible recipe](https://github.com/pahagon/otp-labs/blob/main/ansible/README.md) that helps setup local environment.

First, you should intall ansible ;)

```sh
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible -v 2.9.6
```

## Use this setup in your project

Create a project with all this things using [otp-labs project template](https://github.com/pahagon/otp-labs/blob/main/template/README.md).

## Real world example

The distributed application meal planner called (Umamify)[https://github.com/pahagon/otp-labs/blob/main/umamify/README.md]

## References

- https://david-delassus.medium.com/elixir-and-kubernetes-a-love-story-721cc6a5c7d5
- https://mbuffa.github.io/tips/20201022-elixir-clustering-on-kubernetes/
- https://engineering.dollarshaveclub.com/elixir-otp-applications-on-kubernetes-9944636b8609
- https://learnyousomeerlang.com/what-is-otp
- https://moosecode.nl/blog/introducing_horde
- https://hexdocs.pm/horde/getting_started.
- https://staknine.com/elixir-config-environment-variables/
- https://hexdocs.pm/libcluster/readme.html
- https://firewalltimes.com/load-balancing-vs-server-clustering/
- https://ulisses.dev/elixir/2022/03/04/elixir-modules-files-directories-and-naming-conventions.html
- https://cve.mitre.org/cgi-bin/cvename.cgi?name=2020-24719
- https://samuelmullen.com/articles/elixir-processes-observability/
- https://codesync.global/media/observability-for-elixir-microservices-cbf20/
- https://github.com/erlef/observability-wg
- https://bigardone.dev/blog/2021/06/27/three-real-world-examples-of-distributed-elixir-pt-4
- https://www.freecodecamp.org/news/how-to-build-a-distributed-game-of-life-in-elixir-9152588100cd/
- https://medium.com/wttj-tech/elixir-how-to-distribute-mnesia-between-multiple-nodes-cb7c851b1ed1
- https://github.com/meh/amnesia
- https://blog.appsignal.com/2020/05/19/using-mnesia-in-an-elixir-application.html
- https://medium.com/blackode/elixir-application-start-phases-6ef649845b44
- https://mbuffa.github.io/tips/20201111-elixir-troubleshooting-mnesia/
