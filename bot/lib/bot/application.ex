defmodule Bot.Application do
  use Application
  require Logger

  def start(type, args) do
    cluster_strategy = Application.fetch_env!(:bot, :cluster_strategy)
    topologies = Bot.ClusterStrategy.pick_topologies(cluster_strategy)

    Logger.log(:info, "Starting Module[#{__MODULE__}] ARGS[#{inspect args}] TYPE[#{inspect type}] cluster_strategy[#{inspect cluster_strategy}] topologies[#{inspect topologies}]")

    children = [
      {Cluster.Supervisor, [topologies, [name: Bot.ClusterSupervisor]]},
      {Bot.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bot.Supervisor)
  end
end
