# Bot

**TODO: Add description**

## Running Locally - Single Node

You can run the application locally simply via `iex -S mix`, this will run a single Node
without any clustering.

```sh
$ ERL_FLAGS="-name bot1@127.0.0.1 -setcookie cookie" iex -S mix
```

or you may use make

```sh
$ make run-locally-single 
```

## Running Locally - MultiNode

To run a Cluster locally, run the application multiple times with unique Node names and a
consistent cookie specified via `ERL_FLAGS`, for example this will run a 3 Node cluster:

### Terminal 1
```sh
$ ERL_FLAGS="-name bot1@127.0.0.1 -setcookie cookie" iex -S mix
```

### Terminal 2
```sh
$ ERL_FLAGS="-name bot2@127.0.0.1 -setcookie cookie" iex -S mix
```

### Terminal 3
```sh
$ ERL_FLAGS="-name bot3@127.0.0.1 -setcookie cookie" iex -S mix
```

or you may use make

### Terminal 1
```sh
$ make run-locally-multinode
```

### Terminal 2
```sh
$ make run-locally-multinode
```

### Terminal 3
```sh
$ make run-locally-multinode
```

