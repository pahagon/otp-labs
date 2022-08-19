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
      deps: deps()
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
    OTPLabs Core is lib that provides:
    - Horde, Mnesia Supervisor and Horde Registry.
      - Those loads nodes dynamically when they start. You should use libcluster to make nodes avaliable via Node.list().
    - Horde and Mnesia NodeObserver GenServer.
      - Those recives notitication when a node up and down and update Horde and mnesia cluster.
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
      {:horde, "~> 0.8.7"},
      {:mnesiac, "~> 0.3"}
    ]
  end
end
