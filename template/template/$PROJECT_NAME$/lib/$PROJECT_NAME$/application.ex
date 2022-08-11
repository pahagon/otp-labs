defmodule <%= @project_name_camel_case %>.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(type, args) do
    cluster_strategy = Application.fetch_env!(:<%= @project_name %>, :cluster_strategy)
    topologies = Application.fetch_env!(:<%= @project_name %>, cluster_strategy)

    Logger.log(
      :info,
      "Starting [#{__MODULE__}] ARGS[#{inspect(args)}] TYPE[#{inspect(type)}] cluster_strategy[#{inspect(cluster_strategy)}] topologies[#{inspect(topologies)}]"
    )

    children = [
      {Cluster.Supervisor, [topologies, [name: <%= @project_name_camel_case %>.ClusterSupervisor]]},
      <%= @project_name_camel_case %>.Horde.Registry,
      <%= @project_name_camel_case %>.Horde.Supervisor,
      <%= @project_name_camel_case %>.Horde.NodeObserver,
      {<%= @project_name_camel_case %>.GenServer, args}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: <%= @project_name_camel_case %>.Supervisor)
  end
end
