import Config

config :bot, cluster_strategy: System.get_env("CLUSTER_TOPOLOGIE")

