# OTPLabs Core

OTPLabs Core is lib that provides:
- Horde, Mnesia Supervisor and Horde Registry.
  - Those loads nodes dynamically when they start. You should use libcluster to make nodes avaliable via Node.list().
- Horde and Mnesia NodeObserver.
  - Those recives notitication when a node up and down and update Horde and mnesia cluster.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `otplabs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:otplabs, "~> 0.1.0"}
  ]
end
```

Declare Supervisors, Registry and NodeObserver as a children in you application.

```elixir
defmodule MyApp.Application do
  use Application

  @impl true
  def start(type, args) do
    topologies = ....

    children = [
      {Cluster.Supervisor, [topologies, [name: MyApp.ClusterSupervisor]]},
      OTPLabs.Horde.Registry,
      OTPLabs.Horde.Supervisor,
      OTPLabs.Horde.NodeObserver,
      OTPLabs.Mnesia.Supervisor,
      OTPLabs.Mnesia.NodeObserver,
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
  end
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/optlabs>.

