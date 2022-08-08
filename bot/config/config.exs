import Config

config :bot,
  k8s_gossip: [
    bot: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]

config :bot,
  epmd: [
    bot: [
      strategy: Elixir.Cluster.Strategy.LocalEpmd
    ]
  ]
