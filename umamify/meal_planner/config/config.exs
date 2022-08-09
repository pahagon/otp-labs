import Config

config :meal_planner,
  k8s_gossip: [
meal_planner: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]

config :meal_planner,
  epmd: [
meal_planner: [
      strategy: Elixir.Cluster.Strategy.LocalEpmd
    ]
  ]
