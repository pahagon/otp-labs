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

config :mnesiac,
  stores: [MealPlanner.Recipe.MnesiacStore],
  schema_type: :disc_copies

config :mnesia, dir: '/tmp/mnesia.#{Mix.env}.#{node()}'
