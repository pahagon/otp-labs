defmodule MealPlanner.Planner do
  @moduledoc ~S"""
  This module is used for creating meal suggestions
  """

  alias Timex.DateTime
  alias Umamify.User
  alias MealPlanner.Recipe
  # alias MealPlanner.Recipe.Item

  @typedoc ~S"""
  Type that represents User Recipe Suggestion.
  """
  @type user_recipe_suggestion_t ::
          {:ok, Recipe.t(), User.t(), DateTime.t()} | {:error, String.t(), User.t(), DateTime.t()}

  @doc ~S"""
  Suggest a recipe to a give user and datetime.

  ## Examples

      iex> user_id = :crypto.strong_rand_bytes(10) |> Base.encode16
      iex> now = Timex.now()
      iex> user = %Umamify.User{id: user_id}
      iex> MealPlanner.Planner.suggest_recipe_for(user, now)
      {:error, "yo", %Umamify.User{id: user_id}, now}
  """
  @spec suggest_recipe_for(User.t(), Datetime.t()) :: user_recipe_suggestion_t
  def suggest_recipe_for(user, datetime) do
    {:error, "yo", user, datetime}
  end

  @doc ~S"""
  Register user acceptance for recipe suggestion.

  ## Examples

      iex> user_id = :crypto.strong_rand_bytes(10) |> Base.encode16
      iex> now = Timex.now()
      iex> user = %Umamify.User{id: user_id}
      iex> recipe = %MealPlanner.Recipe{}
      iex> MealPlanner.Planner.accept_recipe_suggestion({:ok, recipe, user, now})
      {:error, "yo", %Umamify.User{id: user_id}, now}
  """
  @spec accept_recipe_suggestion(user_recipe_suggestion_t) :: user_recipe_suggestion_t
  def accept_recipe_suggestion({:ok, _recipe, user, datetime}) do
    {:error, "yo", user, datetime}
  end
end
