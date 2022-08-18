defmodule Umamify.Horde.Supervisor do
  @moduledoc ~S"""
  This module is used for initialize nodes dynamically.
  """

  use Horde.DynamicSupervisor
  require Logger

  def start_link(_) do
    Logger.log(:info, "Starting #{__MODULE__}")

    Horde.DynamicSupervisor.start_link(__MODULE__, [strategy: :one_for_one], name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    Logger.log(:info, "init #{__MODULE__} #{inspect(init_arg)}")

    [members: members()]
    |> Keyword.merge(init_arg)
    |> Horde.DynamicSupervisor.init()
  end

  @impl true
  def start_child(child_spec) do
    Logger.log(:info, "Starting child #{__MODULE__} #{inspect(child_spec)}")

    Horde.DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  defp members() do
    Enum.map([Node.self() | Node.list()], &{__MODULE__, &1})
  end
end
