defmodule Bot.ClusterStrategy do
  @moduledoc ~S"""
  """

  def pick_topologies(cluster_strategy) do
    cond do
      cluster_strategy == "k8s-ip" ->
	[
	  bot: [
	    strategy: Cluster.Strategy.Kubernetes,
	    config: [
	      kubernetes_node_basename: "bot",
	      kubernetes_selector: "app=bot,tier=otu",
	      kubernetes_namespace: "default",
	    ]
	  ]
	]
      cluster_strategy == "k8s-gossip" ->
	[
	  bot: [
	    strategy: Cluster.Strategy.Gossip,
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
