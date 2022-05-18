defmodule Bot.GenServer do
  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, {:ok, opts})
  end

  def init(state = {:ok, opts}) do
    Logger.log(:info, "#{__MODULE__} init #{inspect state}")
    state
  end
end
