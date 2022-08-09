defmodule MealPlanner.Recipe.Item do
  defstruct name: nil, qty: nil, unit: nil

  @type t :: %__MODULE__{name: String.t(), qty: integer(), unit: atom()}
end

defmodule MealPlanner.Recipe do
  defstruct title: nil, instructions: nil, ingredients: nil

  alias MealPlanner.Recipe.Item
  @type t :: %__MODULE__{title: String.t(), instructions: String.t(), ingredients: list(Item.t())}
end

defmodule MealPlanner.Planner do

  alias MealPlanner.Recipe
  alias MealPlanner.Recipe.Item

  @moduledoc ~S"""
  """

  @doc ~S"""
  Suggest a meal plan to a give user

  ## Examples

      iex> user_id = :crypto.strong_rand_bytes(10) |> Base.encode16
      iex> MealPlanner.GordonRamsay.suggest_meal_plan(user_id)
      user_id
  """
  def suggest_meal_plan(user_id) do
    user_id
  end
end
