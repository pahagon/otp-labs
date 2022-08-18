defmodule Umamify.MixProject do
  use Mix.Project

  def project do
    [
      app: :umamify,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:horde, "~> 0.8.7"},
      {:timex, "~> 3.7.9"},
      {:mnesiac, "~> 0.3"},
      {:decimal, "~> 2.0"},
    ]
  end
end
