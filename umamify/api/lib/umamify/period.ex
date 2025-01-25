defmodule Umamify.Period do
  @moduledoc ~S"""
  This module represents a period of the day.
  """

  @typedoc ~S"""
  The period of the day is divied in 4 parts.

  Morning is generally considered the time range from 6 am to noon.
  The afternoon is from noon to 6 pm.
  The evening is from 6 pm to midnight.
  And finally, the night is from midnight to 6 am.
  """
  @type t :: :morning | :afternoon | :evening | :midnight

  @doc ~S"""
  This func returns period by datetime.

  ## Examples
      iex> Umamify.Period.calc(~N[2022-01-01 06:00:00])
      :morning

      iex> Umamify.Period.calc(~N[2022-01-01 11:59:59])
      :morning

      iex> Umamify.Period.calc(~N[2022-01-01 12:00:00])
      :afternoon

      iex> Umamify.Period.calc(~N[2022-01-01 16:00:00])
      :afternoon

      iex> Umamify.Period.calc(~N[2022-01-01 17:59:59])
      :afternoon

      iex> Umamify.Period.calc(~N[2022-01-01 18:00:00])
      :evening

      iex> Umamify.Period.calc(~N[2022-01-01 22:00:00])
      :evening

      iex> Umamify.Period.calc(~N[2022-01-01 23:00:00])
      :evening

      iex> Umamify.Period.calc(~N[2022-01-01 00:00:00])
      :night

      iex> Umamify.Period.calc(~N[2022-01-01 05:00:00])
      :night
  """
  @spec calc(Timex.DateTime.t()) :: t()
  def calc(datetime) do
    cond do
      datetime.hour >= 6  and datetime.hour < 12  -> :morning
      datetime.hour >= 12 and datetime.hour < 18  -> :afternoon
      datetime.hour >= 18 and datetime.hour <= 23 -> :evening
      datetime.hour >= 0 and datetime.hour  < 6   -> :night
    end
  end
end
