defmodule Bot.Horde.NodeObserver do
  @moduledoc ~S"""
  This module is used for updateing Horde Registry and Supervisor dynamically.
  """

  use GenServer
  require Logger

  def start_link(_) do
    Logger.log(:info, "Starting #{__MODULE__}")

    GenServer.start_link(__MODULE__, [])
  end

  @impl true
  def init(_) do
    Logger.log(:info, "init #{__MODULE__}")

    :net_kernel.monitor_nodes(true, node_type: :visible)

    {:ok, nil}
  end

  @impl true
  def handle_info({:nodeup, node, _node_type}, state) do
    Logger.log(:info, "[#{__MODULE__}].handle_info :nodeup - #{inspect(node)} ")

    set_members(Bot.Horde.Registry)
    set_members(Bot.Horde.Supervisor)

    {:noreply, state}
  end

  @impl true
  def handle_info({:nodedown, node, _node_type}, state) do
    Logger.log(:info, "[#{__MODULE__}].handle_info :nodown - #{inspect(node)} ")

    set_members(Bot.Horde.Registry)
    set_members(Bot.Horde.Supervisor)

    {:noreply, state}
  end

  defp set_members(name) do
    members = Enum.map([Node.self() | Node.list()], &{name, &1})

    :ok = Horde.Cluster.set_members(name, members)
  end
end
