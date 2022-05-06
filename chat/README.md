# Chat

**TODO: Add description**

## Running Locally - Single Node

You can run the application locally simply via `iex -S mix`, this will run a single Node
without any clustering.

## Running Locally - MultiNode

To run a Cluster locally, run the application multiple times with unique Node names and a
consistent cookie specified via `ERL_FLAGS`, for example this will run a 3 Node cluster:

```
# Terminal 1
$ ERL_FLAGS="-name chat1@127.0.0.1 -setcookie cookie" iex -S mix

# Terminal 2
$ ERL_FLAGS="-name chat2@127.0.0.1 -setcookie cookie" iex -S mix

# Terminal 3
$ ERL_FLAGS="-name chat3@127.0.0.1 -setcookie cookie" iex -S mix
```