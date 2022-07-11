defmodule Bot.ClusterStrategy do
  @moduledoc ~S"""
  """

  def pick_topologies(cluster_strategy) do
    cond do
      cluster_strategy == "k8s-dns" ->
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
