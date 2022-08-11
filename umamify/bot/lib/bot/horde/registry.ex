defmodule Bot.Horde.Registry do
  @moduledoc ~S"""
  This module is used for regestering nodes dynamically.
  """

  use Horde.Registry
  require Logger

  def start_link(_) do
    Logger.log(:info, "Starting #{__MODULE__}")

    Horde.Registry.start_link(__MODULE__, [keys: :unique], name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    Logger.log(:info, "init #{__MODULE__} #{inspect(init_arg)}")

    [members: members()]
    |> Keyword.merge(init_arg)
    |> Horde.Registry.init()
  end

  defp members() do
    Enum.map([Node.self() | Node.list()], &{__MODULE__, &1})
  end
end
