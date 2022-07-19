# OTP Labs
OTP Labs is a demo application built with Elixir and OTP to show how to integrate
Distributed Elixir on Kubernetes with Horde and LibCluster. 

## OTP
OTP stands for Open Telecom Platform, although it's not that much about telecom 
anymore (it's more about software that has the property of telecom applications, but yeah.) 
If half of Erlang's greatness comes from its concurrency and distribution and 
the other half comes from its error handling capabilities, 
then the OTP framework is the third half of it.

## Elixir
Elixir is a functional, concurrent, general-purpose programming language that runs on the BEAM virtual machine 
which is also used to implement the Erlang programming language. Elixir builds on top of Erlang and shares 
the same abstractions for building distributed, fault-tolerant applications

## Horde
Distribute your application over multiple servers with Horde.

You should use Horde when you want a global supervisor (or global registry, or some combination of the two) 
that supports automatic fail-over, dynamic cluster membership, and graceful node shutdown.

## LibCluster
This library provides a mechanism for automatically forming clusters of Erlang nodes, with either static or dynamic node membership. 
It provides a pluggable "strategy" system, with a variety of strategies provided out of the box.

## References
* https://david-delassus.medium.com/elixir-and-kubernetes-a-love-story-721cc6a5c7d5
* https://mbuffa.github.io/tips/20201022-elixir-clustering-on-kubernetes/
* https://engineering.dollarshaveclub.com/elixir-otp-applications-on-kubernetes-9944636b8609
* https://learnyousomeerlang.com/what-is-otp
* https://moosecode.nl/blog/introducing_horde
* https://hexdocs.pm/horde/getting_started.
* https://staknine.com/elixir-config-environment-variables/
* https://hexdocs.pm/libcluster/readme.html
* https://firewalltimes.com/load-balancing-vs-server-clustering/
* https://ulisses.dev/elixir/2022/03/04/elixir-modules-files-directories-and-naming-conventions.html
* https://cve.mitre.org/cgi-bin/cvename.cgi?name=2020-24719
* https://samuelmullen.com/articles/elixir-processes-observability/
* https://codesync.global/media/observability-for-elixir-microservices-cbf20/
* https://github.com/erlef/observability-wg

## Developing

### Setup local env for Ubuntu distro

Step 1: You should intall ansible

```sh 
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible -v 2.9.6
```

Step 2: You should clone this repo

```sh 
$ git clone git@github.com:pahagon/otp-labs.git
```

Setup 3: You should run ansible in order to setup you local environment

```sh 
$ cd PROJECT_PATH/ansible
$ ansible-plabook localhost-dev.yml --ask-become
```

Setup 4: Start minikube

```sh
$ minikube start
```
