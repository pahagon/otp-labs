defmodule Umamify.Geolocation do
  @moduledoc ~S"""
  This module represents geolocation.
  """

  defstruct latitude: nil, longitude: nil

  @type t :: %__MODULE__{
          latitude: Decimal.t(),
          longitude: Decimal.t()
        }
end
