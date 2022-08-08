import Config

config :brainiac,
  k8s_gossip: [
brainiac: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]

config :brainiac,
  epmd: [
brainiac: [
      strategy: Elixir.Cluster.Strategy.LocalEpmd
    ]
  ]
