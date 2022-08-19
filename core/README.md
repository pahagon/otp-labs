# OTPLabs Core

OTPLabs Core is lib for Elixir application that provides:
- Horde, Mnesia Supervisor and Horde Registry. (Those loads nodes dynamically when they start).
- Horde and Mnesia NodeObserver. (Those recives notitication when a node up and down and update Horde Cluster).

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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/core>.

