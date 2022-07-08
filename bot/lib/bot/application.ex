defmodule Bot.Application do
  use Application
  require Logger

  def start(type, args) do
    Logger.log(:info, "Started Module[#{__MODULE__}] ARGS[#{inspect args}] TYPE[#{inspect type}]")

    runtime_config = Bot.RuntimeConfig.load!()
    topologies = Bot.ClusterStrategy.pick_topologies(runtime_config.topologie)

    children = [
      {Cluster.Supervisor, [topologies, [name: Bot.ClusterSupervisor]]},
      {Bot.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bot.Supervisor)
  end
end
