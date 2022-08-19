defmodule Bot.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(type, args) do
    cluster_strategy = Application.fetch_env!(:bot, :cluster_strategy)
    topologies = Application.fetch_env!(:bot, cluster_strategy)

    Logger.log(
      :info,
      "Starting [#{__MODULE__}] ARGS[#{inspect(args)}] TYPE[#{inspect(type)}] cluster_strategy[#{inspect(cluster_strategy)}] topologies[#{inspect(topologies)}]"
    )

    children = [
      {Cluster.Supervisor, [topologies, [name: Bot.ClusterSupervisor]]},
      OTPLabs.Horde.Registry,
      OTPLabs.Horde.Supervisor,
      OTPLabs.Horde.NodeObserver,
      {Bot.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bot.Supervisor)
  end
end
