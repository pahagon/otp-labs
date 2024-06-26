defmodule MealPlanner.MixProject do
  use Mix.Project

  def project do
    [
      app: :meal_planner,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MealPlanner.Application, []}
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
      # {:otplabs, "~> 0.1.0"},
      {:otplabs, path: "../../otplabs-lib"},
      {:timex, "~> 3.7.11"},

      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.36"},
    ]
  end
end
