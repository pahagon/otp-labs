import Config

config :<%= @project_name %>,
  k8s_gossip: [
  <%= @project_name %>: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]

config :<%= @project_name %>,
  epmd: [
  <%= @project_name %>: [
      strategy: Elixir.Cluster.Strategy.LocalEpmd
    ]
  ]
