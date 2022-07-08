defmodule Bot.RuntimeConfig do
  @moduledoc ~S"""
    Loads dynamic configuration at runtime.
  """

  @behaviour Vapor.Plan

  @impl Vapor.Plan
  def config_plan do
    %Vapor.Provider.Env{
      bindings: [
	topologie: "topologie"
      ]
    }
  end

  # If values could not be found we raise an exception and halt the boot process
  def load!() do
    Vapor.load!(Bot.RuntimeConfig)
  end
end
