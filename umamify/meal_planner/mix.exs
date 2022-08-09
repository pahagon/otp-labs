defmodule MealPlanner.MixProject do
  use Mix.Project

  def project do
    [
      app: :meal_planner,
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
      mod: {MealPlanner.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 3.3.0"},
      {:horde, "~> 0.8.7"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:timex, "~> 3.7.9"}
    ]
  end
end
