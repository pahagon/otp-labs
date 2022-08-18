defmodule MealPlanner.Suggestion do
  @moduledoc ~S"""
  This module represents a meal suggestion.
  """
  defstruct user_id: nil, recipe_id: nil, day: nil, period: nil

  @typedoc ~S"""
  Morning is generally considered the time range from 6 am to noon.
  The afternoon is from noon to 6 pm.
  The evening is from 6 pm to midnight.
  And finally, the night is from midnight to 6 am.
  """
  @type period_t :: :morning | :afternoon | :evening | :midnight

  @typedoc ~S"""
  Type that represents Meal Suggestion
  """
  @type t :: %__MODULE__{
          user_id: integer(),
          recipe_id: integer(),
          day: Timex.Date.t(),
          period: period_t()
        }
end
