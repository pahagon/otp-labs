defmodule OTPLabs.Horde.Registry do
  @moduledoc ~S"""
  This module is used for registering nodes dynamically.
  """

  use Horde.Registry
  require Logger

  @doc false
  def start_link(_) do
    Logger.log(:info, "Starting #{__MODULE__}")

    Horde.Registry.start_link(__MODULE__, [keys: :unique], name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    Logger.log(:info, "#{__MODULE__} init #{inspect(init_arg)}")

    [members: members()]
    |> Keyword.merge(init_arg)
    |> Horde.Registry.init()
  end

  defp members() do
    Enum.map([Node.self() | Node.list()], &{__MODULE__, &1})
  end
end
