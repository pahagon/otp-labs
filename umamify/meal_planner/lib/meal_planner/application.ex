defmodule MealPlanner.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(type, args) do
    cluster_strategy = Application.fetch_env!(:meal_planner, :cluster_strategy)
    topologies = Application.fetch_env!(:meal_planner, cluster_strategy)

    Logger.log(
      :info,
      "Starting [#{__MODULE__}] ARGS[#{inspect(args)}] TYPE[#{inspect(type)}] cluster_strategy[#{inspect(cluster_strategy)}] topologies[#{inspect(topologies)}]"
    )

    children = [
      {Cluster.Supervisor, [topologies, [name: MealPlanner.ClusterSupervisor]]},
      Umamify.Horde.Registry,
      Umamify.Horde.Supervisor,
      Umamify.Horde.NodeObserver,
      Umamify.Mnesia.Supervisor,
      Umamify.Mnesia.NodeObserver,
      {MealPlanner.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MealPlanner.Supervisor)
  end
end
