defmodule MealPlanner.Suggestion do
  @moduledoc ~S"""
  This module represents a meal suggestion.
  """
  defstruct user_id: nil, recipe_id: nil, day: nil, period: nil

  alias Timex.DateTime

  @typedoc ~S"""
  Morning is generally considered the time range from 6 am to noon.
  The afternoon is from noon to 6 pm.
  The evening is from 6 pm to midnight.
  And finally, the night is from midnight to 6 am.
  """
  @type period_t :: :morning | :afternoon | :evening | :midnight

  @typedoc ~S"""
  Type that represents Meal Suggestion.
  """
  @type t :: %__MODULE__{
          user_id: integer(),
          recipe_id: integer(),
          day: Timex.Date.t(),
          period: period_t()
        }

  @doc ~S"""
  This func returns period by datetime.

  Morning is generally considered the time range from 6 am to noon.
  The afternoon is from noon to 6 pm.
  The evening is from 6 pm to midnight.
  And finally, the night is from midnight to 6 am.

  ## Examples
      iex> MealPlanner.Suggestion.period(~N[2022-01-01 06:00:00])
      :morning

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 11:59:59])
      :morning

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 12:00:00])
      :afternoon

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 16:00:00])
      :afternoon

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 17:59:59])
      :afternoon

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 18:00:00])
      :evening

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 22:00:00])
      :evening

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 23:00:00])
      :evening

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 00:00:00])
      :night

      iex> MealPlanner.Suggestion.period(~N[2022-01-01 05:00:00])
      :night
  """
  @spec period(DateTime.t()) :: period_t()
  def period(datetime) do
    cond do
      datetime.hour >= 6  and datetime.hour < 12  -> :morning
      datetime.hour >= 12 and datetime.hour < 18  -> :afternoon
      datetime.hour >= 18 and datetime.hour <= 23 -> :evening
      datetime.hour >= 0 and datetime.hour  < 6   -> :night
    end
  end
end
