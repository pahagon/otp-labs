defmodule Bot.ClusterStrategy do
  @moduledoc ~S"""
  """

  def pick_topologies(topologie_strategy) do
    cond do
      topologie_strategy == "" ->
	[
	  bot: [
	    strategy: Cluster.Strategy.Kubernetes.DNS,
	    config: [
	      service: "bot-svc-headless",
	      application_name: "bot"
	    ]
	  ]
	]
      true ->
	[
	  bot: [
	    strategy: Elixir.Cluster.Strategy.LocalEpmd
	  ]
	]
    end
  end
end
