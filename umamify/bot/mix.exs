defmodule Bot.MixProject do
  use Mix.Project

  def project do
    [
      app: :bot,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Bot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.11", only: :dev},
      {:earmark, "~> 0.1", only: :dev},
      {:dialyxir, "~> 0.3", only: [:dev]},
      {:libcluster, "~> 3.3.0"},
      {:otplabs, "~> 0.1"}
      # {:otplabs, path: "../../otplabs-lib"}
    ]
  end
end
