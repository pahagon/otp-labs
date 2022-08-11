import Config

config :meal_planner,
  cluster_strategy: System.get_env("CLUSTER_STRATEGY", "epmd") |> String.to_atom()

config :logger, :console,
  level: System.get_env("LOG_LEVEL", "debug") |> String.to_atom(),
  format: "$time $metadata[$level] $message \n"
