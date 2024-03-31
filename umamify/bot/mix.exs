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
      {:credo, "~> 1.7.5", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18.0", only: :test},
      {:ex_doc, "~> 0.18.4", only: :dev},
      {:earmark, "~> 1.4.46", only: :dev},
      {:dialyxir, "~> 1.4.3", only: [:dev]},
      {:libcluster, "~> 3.3.3"},
      {:otplabs, "~> 0.1.0"},
      # {:otplabs, path: "../../otplabs-lib"},
      {:timex, "~> 3.7.11"},
    ]
  end
end
