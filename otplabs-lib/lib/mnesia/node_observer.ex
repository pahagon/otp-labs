defmodule OTPLabs.Mnesia.NodeObserver do
  @moduledoc ~S"""
  This module is used for updateing Mnesia nodes dynamically.
  """

  use GenServer
  require Logger

  @doc false
  def start_link(_opts) do
    Logger.log(:info, "Starting #{__MODULE__}")

    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(state) do
    Logger.log(:info, "init #{__MODULE__}")

    :net_kernel.monitor_nodes(true, node_type: :visible)

    {:ok, state}
  end

  @impl true
  def handle_info({:nodeup, node, _node_type}, state) do
    Logger.log(:info, "[#{__MODULE__}].handle_info :nodeup - #{inspect(node)} ")

    case Mnesiac.connect(node) do
      {:ok, _} ->
        Logger.log(:info, "Connected to #{inspect(node)}")

      {:error, reason} ->
        Logger.log(:error, "Failed to connect to #{inspect(node)}: #{inspect(reason)}")
    end

    {:noreply, state}
  end

  @impl true
  def handle_info({:nodedown, node, _node_type}, state) do
    Logger.log(:info, "[#{__MODULE__}].handle_info :nodown - #{inspect(node)} ")

    # :mnesia.change_config(:extra_db_nodes, Node.list())

    {:noreply, state}
  end
end
