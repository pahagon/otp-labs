import Config

config :bot,
  k8s_ip: [
    bot: [
      strategy: Cluster.Strategy.Kubernetes,
      config: [
        kubernetes_node_basename: "bot",
        kubernetes_selector: "app=bot,tier=otp",
        kubernetes_namespace: "default"
      ]
    ]
  ]

config :bot,
  k8s_gossip: [
    bot: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]

config :bot,
  epmd: [
    bot: [
      strategy: Elixir.Cluster.Strategy.LocalEpmd
    ]
  ]
