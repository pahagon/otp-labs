defmodule OtpLibclusterHordeTemplateProject.Mixfile do
  use Mix.Project

  @name :otp_libcluster_horde_template_project

  def project do
    in_production = Mix.env() == :prod

    [
      app: @name,
      version: "0.1.0",
      deps: deps(),
      elixir: "~> 1.13",
      package: package(),
      description: "OTP template project that ties Kubernetes, LibCluster and Horde.",
      build_embedded: in_production,
      start_permanent: in_production
    ]
  end

  defp package do
    [
      name: @name,
      files: ["lib", "mix.exs", "README.md", "LICENSE.md", "template"],
      maintainers: ["Paulo Ahagon <pahagon@gmail.com>"],
      licenses: ["Apache 2.0"],
      links: %{
        GitHub: "https://github.com/pahagon/otp-labs/template"
      }
    ]
  end

  defp deps do
    [
      {:mix_templates, ">0.0.0", app: false},
      {:ex_doc, ">0.0.0", only: [:dev, :test]}
    ]
  end
end
