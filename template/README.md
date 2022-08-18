# Project that ties otp, kubernetes, libcluster and hord

This project is an elixir project generator for all projects in otp-labs.
It tries to save a couple of your minutes tidying configuration and dependency.

This project uses template system created by [Dave Thomas](https://pragdave.me/blog/2017/04/18/elixir-project-generator.html).

## Installation

First you need install the template system.

```shell
make clone_pragdave_repos install_template_system
```

And then you need install the OTP-libcluster-horde template project

```shell
make install_otp_libcluster_horde_template
```

## Creating a new project

Let's say you want create a project with name __foo__

```shell
mix gen otp_libcluster_horde_template_project foo
```

output:

```
* creating ./foo
* creating ./foo/mix.exs
* creating ./foo/.credo.exs
* creating ./foo/.formatter.exs
* creating ./foo/.tool-versions
* creating ./foo/LICENSE.md
* creating ./foo/.dockerignore
* creating ./foo/README.md
* creating ./foo/lib
* creating ./foo/lib/foo
* creating ./foo/lib/foo/horde
* creating ./foo/lib/foo/horde/supervisor.ex
* creating ./foo/lib/foo/horde/registry.ex
* creating ./foo/lib/foo/horde/node_observer.ex
* creating ./foo/lib/foo/gen_server.ex
* creating ./foo/lib/foo/application.ex
* creating ./foo/lib/foo.ex
* creating ./foo/config
* creating ./foo/config/runtime.exs
* creating ./foo/config/config.exs
* creating ./foo/CHANGELOG.md
* creating ./foo/test
* creating ./foo/test/test_helper.exs
* creating ./foo/k8s
* creating ./foo/k8s/service-headless.yml
* creating ./foo/k8s/deployment.yml
* creating ./foo/.gitignore
* creating ./foo/Makefile
* creating ./foo/rel
* creating ./foo/rel/vm.args.eex
* creating ./foo/rel/env.sh.eex
* creating ./foo/rel/remote.vm.args.eex
* creating ./foo/Dockerfile
Successfully generated foo in .
```

make sure __epmd__ is running

```shell
epmd -daemon
```

### Running locally

```shell
cd foo && mix do format, deps.get, compile && make run-locally-multinode 
```

Output:

```
Resolving Hex dependencies...
Dependency resolution completed:
New:
  bunt 0.2.0
  credo 1.6.6
  delta_crdt 0.6.4
  file_system 0.2.10
  horde 0.8.7
  jason 1.3.0
  libcluster 3.3.1
  libring 1.6.0
  merkle_map 0.2.1
  telemetry 1.1.0
  telemetry_poller 1.0.0
* Getting libcluster (Hex package)
* Getting horde (Hex package)
* Getting credo (Hex package)
* Getting bunt (Hex package)
* Getting file_system (Hex package)
* Getting jason (Hex package)
* Getting delta_crdt (Hex package)
* Getting libring (Hex package)
* Getting telemetry (Hex package)
* Getting telemetry_poller (Hex package)
* Getting merkle_map (Hex package)
==> file_system
Compiling 7 files (.ex)
Generated file_system app
==> merkle_map
Compiling 7 files (.ex)
Generated merkle_map app
==> bunt
Compiling 2 files (.ex)
Generated bunt app
===> Analyzing applications...
===> Compiling telemetry
==> delta_crdt
Compiling 5 files (.ex)
Generated delta_crdt app
===> Analyzing applications...
===> Compiling telemetry_poller
==> jason
Compiling 10 files (.ex)
Generated jason app
==> libcluster
Compiling 13 files (.ex)
Generated libcluster app
==> credo
Compiling 242 files (.ex)
Generated credo app
==> libring
Compiling 5 files (.ex)
Generated libring app
==> horde
Compiling 13 files (.ex)
Generated horde app
==> foo
Compiling 6 files (.ex)
Generated foo app

ERL_FLAGS="-name `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g' | sed -r 's/_([a-z])/-\1/gi'`-`head -128 /dev/urandom | cksum | cut -d ' ' -f1`j@127.0.0.1 -setcookie cookie" iex -S mix
Erlang/OTP 24 [erts-12.3.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit]

21:51:57.578 [info] Starting [Elixir.Foo.Application] ARGS[[]] TYPE[:normal] cluster_strategy[:epmd] topologies[[foo: [strategy: Cluster.Strategy.LocalEpmd]]]
21:51:57.591 [info] Starting Elixir.Foo.Horde.Registry
21:51:57.593 [info] init Elixir.Foo.Horde.Registry [keys: :unique]
21:51:57.603 [info] Starting Horde.RegistryImpl with name Foo.Horde.Registry
21:51:57.609 [info] Starting Elixir.Foo.Horde.Supervisor
21:51:57.611 [info] init Elixir.Foo.Horde.Supervisor [strategy: :one_for_one]
21:51:57.619 [info] Starting Horde.DynamicSupervisorImpl with name Foo.Horde.Supervisor
21:51:57.621 [info] Starting Elixir.Foo.Horde.NodeObserver
21:51:57.621 [info] init Elixir.Foo.Horde.NodeObserver
21:51:57.621 [info] Elixir.Foo.GenServer start_link Foo.GenServer
21:51:57.625 [info] Elixir.Foo.GenServer init {:ok, Foo.GenServer}
Interactive Elixir (1.13.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(foo-2378306091j@127.0.0.1)1> 
```

You should open another terminal session and type

```shell
make run-locally-multinode
```

Output:

```
ERL_FLAGS="-name `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g' | sed -r 's/_([a-z])/-\1/gi'`-`head -128 /dev/urandom | cksum | cut -d ' ' -f1`j@127.0.0.1 -setcookie cookie" iex -S mix
Erlang/OTP 24 [erts-12.3.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit]

21:55:15.481 [info] Starting [Elixir.Foo.Application] ARGS[[]] TYPE[:normal] cluster_strategy[:epmd] topologies[[foo: [strategy: Cluster.Strategy.LocalEpmd]]]
21:55:15.512 [info] [libcluster:foo] connected to :"foo-2378306091j@127.0.0.1"
21:55:15.512 [info] Starting Elixir.Foo.Horde.Registry
21:55:15.514 [info] init Elixir.Foo.Horde.Registry [keys: :unique]
21:55:15.523 [info] Starting Horde.RegistryImpl with name Foo.Horde.Registry
21:55:15.530 [info] Starting Elixir.Foo.Horde.Supervisor
21:55:15.532 [info] init Elixir.Foo.Horde.Supervisor [strategy: :one_for_one]
21:55:15.541 [info] Starting Horde.DynamicSupervisorImpl with name Foo.Horde.Supervisor
21:55:15.542 [info] Starting Elixir.Foo.Horde.NodeObserver
21:55:15.542 [info] init Elixir.Foo.Horde.NodeObserver
21:55:15.542 [info] Elixir.Foo.GenServer start_link Foo.GenServer
21:55:15.545 [info] Elixir.Foo.GenServer init {:ok, Foo.GenServer}
Interactive Elixir (1.13.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(foo-2931448500j@127.0.0.1)1>
```

You are going to see in the first terminal, node joining in to cluster

```
21:55:15.509 [info] [Elixir.Foo.Horde.NodeObserver].handle_info :nodeup - :"foo-2931448500j@127.0.0.1"
21:55:15.829 [info] Elixir.Foo.GenServer start_link Foo.GenServer
21:55:15.840 [info] already started at #PID<21469.272.0>, returning :ignore
```

You can check the nodes that has joined to the cluster.

```
iex(foo-2931448500j@127.0.0.1)1> Node.list()
[:"foo-2378306091j@127.0.0.1"]
```

That's it, There is a little cluster on you localhost.

### Running on minikube

Make sure minikube is running

```shell
minikube start
```

Run on minikube

```shell
eval $(minikube -p minikube docker-env) && make build && make kubectl-create
```

You can check if application is running on minukube.

```shell
kubectl get pods
```

Output

```
NAME                                     READY   STATUS    RESTARTS        AGE
foo-deployment-58dd7578dd-5prlc          1/1     Running   0               63s
foo-deployment-58dd7578dd-6f9vv          1/1     Running   0               63s
foo-deployment-58dd7578dd-pvs97          1/1     Running   0               63s
```

You can check if all nodes are connected.

```shell
docker ps
```

Output:

```
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS     NAMES
35e7960d8dfe   949c9ac5cc58           "/bin/sh -c '/opt/ap…"   3 minutes ago   Up 3 minutes             k8s_foo_foo-deployment-58dd7578dd-5prlc_default_e3d426da-1656-4d7b-b80c-c47ba00fb403_0
16295998097c   949c9ac5cc58           "/bin/sh -c '/opt/ap…"   3 minutes ago   Up 3 minutes             k8s_foo_foo-deployment-58dd7578dd-6f9vv_default_aceaa742-d622-4759-a9e3-9e08f1c0852a_0
8211d29a4ab0   949c9ac5cc58           "/bin/sh -c '/opt/ap…"   3 minutes ago   Up 3 minutes             k8s_foo_foo-deployment-58dd7578dd-pvs97_default_aca5e614-6091-4652-8a1e-73f8abbb7215_0
```

You should copy one of listed container id and connect via bash.

```shell
docker exec -it 35e7960d8dfe /bin/bash
```

Now you are able to connect on node remotelly

```shell
cd bin/ && ./foo remote
```

Output:

```
Erlang/OTP 24 [erts-12.3.2.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit:no-native-stack]

Interactive Elixir (1.13.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(foo@172-17-0-13.default.pod.cluster.local)1>
```

You can check which node are connected on cluster.

```
iex(foo@172-17-0-13.default.pod.cluster.local)1> Node.list()
[:"foo@172-17-0-12.default.pod.cluster.local",
 :"foo@172-17-0-11.default.pod.cluster.local"]
```

Voalá
