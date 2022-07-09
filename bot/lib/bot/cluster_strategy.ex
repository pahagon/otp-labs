defmodule Bot.ClusterStrategy do
  @moduledoc ~S"""
  """

  def pick_topologies(_topologie_strategy) do
    cond do
      true ->
	[
	  bot: [
	    strategy: Elixir.Cluster.Strategy.LocalEpmd
	  ]
	]
    end
  end
end
