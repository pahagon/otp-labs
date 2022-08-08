# bot
**TODO: Add description**

## Developing

### Running Locally 
First, you should start Erlang Port Mapper Daemon.
This daemon acts as a name server on all hosts involved in distributed Erlang computations.

```sh
$ epmd -daemon
```

#### Single Node
You can run the application locally simply via `iex -S mix`, this will run a single Node
without any clustering.

```sh
$ ERL_FLAGS="-name bot1@127.0.0.1 -setcookie cookie" iex -S mix
```

or you may use make

```sh
$ make run-locally-single 
```

#### MultiNode
To run a Cluster locally, run the application multiple times with unique Node names and a
consistent cookie specified via `ERL_FLAGS`, for example this will run a 3 Node cluster:

##### Terminal 1
```sh
$ ERL_FLAGS="-name Bot1@127.0.0.1 -setcookie cookie" iex -S mix
```

##### Terminal 2
```sh
$ ERL_FLAGS="-name Bot2t@127.0.0.1 -setcookie cookie" iex -S mix
```

##### Terminal 3
```sh
$ ERL_FLAGS="-name Bot3@127.0.0.1 -setcookie cookie" iex -S mix
```

or you may use make

##### Terminal 1
```sh
$ make run-locally-multinode
```

##### Terminal 2
```sh
$ make run-locally-multinode
```

##### Terminal 3
```sh
$ make run-locally-multinode
```

#### Docker
First you should create docker image

```
$ make build
```

After that you may run the app in docker
```
$ make run-docker
```

### Running on `minikube`

To run on `minikube`, start it up and then deploy the charts:

```
$ eval $(minikube -p minikube docker-env)
$ make build
$ minikube image load bot:latest
$ minikube cache reload
$ kubectl create -f k8s/service-headless.yml
$ kubectl create -f k8s/deployment.yml
```
