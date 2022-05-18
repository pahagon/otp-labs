# OTP Labs

OTP Labs is a demo application built with Elixir and OTP to show how to integrate
Distributed Elixir on Kubernetes with Horde, LibCluster, and Distillery. 

## Developing

### Ubuntu

First step is: You should intall ansible

```sh 
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible -v 2.9.6
```

Second step is: You should clone this repo

```sh 
$ git clone git@github.com:pahagon/otp-labs.git
```

Third setup is: Ansible going to setup local environment

```sh 
$ cd PROJECT_PATH/ansible
$ ansible-plabook localhost-dev.yml --ask-become
```

## Horde
Distribute your application over multiple servers with Horde.

You should use Horde when you want a global supervisor (or global registry, or some combination of the two) 
that supports automatic fail-over, dynamic cluster membership, and graceful node shutdown.

https://moosecode.nl/blog/introducing_horde
https://hexdocs.pm/horde/getting_started.



