defmodule OTPLabs.Mnesia.Supervisor do
  @moduledoc ~S"""
  This module is used for initialize mnesia with nodes dynamically.
  """

  require Logger
  use Supervisor

  @doc false
  def start_link(args) do
    Logger.log(:info, "Starting #{__MODULE__}")

    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    Logger.log(:info, "init #{__MODULE__}")

    Mnesiac.init_mnesia(Node.list())

    opts = Keyword.put(opts, :strategy, :one_for_one)
    Supervisor.init([], opts)
  end
end
