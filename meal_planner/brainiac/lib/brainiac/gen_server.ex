defmodule Brainiac.GenServer do
  use GenServer
  require Logger

  def child_spec(opts) do
    name = Keyword.get(opts, :name, __MODULE__)

    %{
      id: "#{__MODULE__}_#{name}",
      start: {__MODULE__, :start_link, [name]},
      shutdown: 10_000,
      restart: :transient
    }
  end

  def start_link(name) do
    Logger.log(:info, "#{__MODULE__} start_link #{inspect(name)}")

    case GenServer.start_link(__MODULE__, {:ok, name}, name: via_tuple(name)) do
      {:error, {:already_started, pid}} ->
        Logger.log(:info, "already started at #{inspect(pid)}, returning :ignore")
        :ignore

      whatelse ->
        whatelse
    end
  end

  @impl true
  def init(state) do
    Logger.log(:info, "#{__MODULE__} init #{inspect(state)}")
    state
  end

  defp via_tuple(name), do: {:via, Horde.Registry, {Brainiac.Registry, name}}
end
