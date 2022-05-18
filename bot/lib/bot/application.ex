defmodule Bot.Application do
  use Application
  require Logger

  def start(types, args) do
    Logger.log(:info, "Started #{__MODULE__} #{inspect args} #{inspect types}")

    topologies = [
      user: [
	strategy: Elixir.Cluster.Strategy.LocalEpmd
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: Bot.ClusterSupervisor]]},
      {Bot.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bot.Supervisor)
  end
end
