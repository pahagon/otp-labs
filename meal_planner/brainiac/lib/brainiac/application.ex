defmodule Brainiac.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(type, args) do
    cluster_strategy = Application.fetch_env!(:brainiac, :cluster_strategy)
    topologies = Application.fetch_env!(:brainiac, cluster_strategy)

    Logger.log(
      :info,
      "Starting [#{__MODULE__}] ARGS[#{inspect(args)}] TYPE[#{inspect(type)}] cluster_strategy[#{inspect(cluster_strategy)}] topologies[#{inspect(topologies)}]"
    )

    children = [
      {Horde.Registry, [name: Brainiac.Registry, keys: :unique]},
      {Horde.DynamicSupervisor, [name: Brainiac.DistributedSupervisor, strategy: :one_for_one]},
      {Cluster.Supervisor, [topologies, [name: Brainiac.ClusterSupervisor]]},
      {Brainiac.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Brainiac.Supervisor)
  end
end
