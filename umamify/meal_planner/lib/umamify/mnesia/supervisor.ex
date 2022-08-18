defmodule Umamify.Mnesia.Supervisor do
  @moduledoc false
  require Logger
  use Supervisor

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
