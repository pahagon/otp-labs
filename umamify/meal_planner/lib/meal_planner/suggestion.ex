defmodule MealPlanner.Suggestion do
  @moduledoc ~S"""
  This module represents a meal suggestion.
  """
  defstruct user_id: nil, recipe: nil, day: nil, period: nil

  alias Umamify.Period
  alias MealPlanner.Recipe

  @typedoc ~S"""
  Type that represents Meal Suggestion.
  """
  @type t :: %__MODULE__{
          user_id: integer(),
          recipe: list(Recipe.t()),
          day: Timex.Date.t(),
          period: Period.t()
  }
  @doc ~S"""
  This function check if is an item is valid

  ## Examples
      iex> MealPlanner.Suggestion.valid?(nil)
      {:error, "suggestion is nil", nil}

      iex> s = %MealPlanner.Suggestion{}
      iex> MealPlanner.Suggestion.valid?(s)
      {:error, "user_id is nil, recipe is nil, period is nil, day is nil", s}

      iex> item = %MealPlanner.Recipe.Ingredient{name: "pasta", quantity: 0.1, unit: :kg}
      iex> recipe = %MealPlanner.Recipe{id: 1, title: "Chicken Pasta", instructions: "Cookie", ingredients: [item]}
      iex> day = ~D[2022-01-01]
      iex> period = Umamify.Period.calc(~N[2022-01-01 06:00:00])
      iex> s = %MealPlanner.Suggestion{user_id: 1, recipe: recipe, day: day, period: period}
      iex> MealPlanner.Suggestion.valid?(s)
      {:ok, s}

  """
  @spec valid?(__MODULE__.t()) :: {:ok, __MODULE__.t()} | {:error, String.t(), __MODULE__.t()}
  def valid?(suggestion) do
    cond do
      suggestion == nil ->
        {:error, "suggestion is nil", nil}

      suggestion != nil ->
        nil_attrs = filter_nil_attrs(suggestion)

        nil_attrs
        |> Enum.empty?()
        |> if(do: {:ok, suggestion}, else: {:error, Enum.join(nil_attrs, ", "), suggestion})

      # best pratice
      true ->
        {:error, "Unknown", suggestion}
    end
  end

  defp filter_nil_attrs(suggestion) do
    suggestion
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce(
      [],
      fn attr, acc ->
        value = Map.get(suggestion, attr)

        cond do
          is_nil(value) ->
            ["#{attr} is nil" | acc]

          is_binary(value) && String.trim(value) == "" ->
            ["#{attr} is empty" | acc]

          true ->
            acc
        end
      end
    )
  end
end
