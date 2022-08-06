# How to setup local OTP-labs environment on Ubuntu

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
