defmodule OTPLabs.MixProject do
  use Mix.Project

  def project do
    [
      app: :otplabs,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      dialyzer: [
        plt_ignore_apps: [:mnesia]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Otplabs-lib provides Horde and Mnesia Supervisor, Horde Registry and NodeObserver that loads nodes dynamically
    when they start. Those recives notitication when a node up and down and update Horde and mnesia cluster.
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README.md"],
     maintainers: ["Paulo Ahagon"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/pahagon/otp-labs"}
     ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.11", only: :dev},
      {:earmark, "~> 0.1", only: :dev},
      {:dialyxir, "~> 0.3", only: [:dev]},
      {:horde, "~> 0.8.7"},
      {:mnesiac, "~> 0.3"},
    ]
  end
end
