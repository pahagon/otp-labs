defmodule Bot.ClusterStrategy do
  @moduledoc ~S"""
  """

  def pick_topologies(topologie_strategy) do
    strategy = cond do
      topologie_strategy == "localepmd" -> Elixir.Cluster.Strategy.LocalEpmd
      true -> raise "Strategy not found"
    end
    [
      bot: [
	strategy: strategy
      ]
    ]
  end
end
