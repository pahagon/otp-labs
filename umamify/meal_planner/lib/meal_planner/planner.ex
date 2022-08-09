defmodule Umamify.User do
  @moduledoc false
  defstruct id: nil, name: nil

  @typedoc ~S"""
  Type that represents User
  """
  @type t :: %__MODULE__{id: String.t(), name: String.t()}
end

defmodule MealPlanner.Recipe.Item do
  @moduledoc false
  defstruct name: nil, qty: nil, unit: nil

  @typedoc ~S"""
  Type that represents Recipe Item
  """
  @type t :: %__MODULE__{name: String.t(), qty: float(), unit: atom()}
end

defmodule MealPlanner.Recipe do
  @moduledoc false
  defstruct title: nil, instructions: nil, ingredients: nil

  alias MealPlanner.Recipe.Item

  @typedoc ~S"""
  Type that represents Recipe
  """
  @type t :: %__MODULE__{title: String.t(), instructions: String.t(), ingredients: list(Item.t())}
end

defmodule MealPlanner.Planner do
  @moduledoc ~S"""
  This module is used for creating meal suggestions
  """

  alias Timex.DateTime
  alias Umamify.User
  alias MealPlanner.Recipe
  #alias MealPlanner.Recipe.Item

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
      iex> recipe = %MealPlanner.Rececipe{}
      iex> MealPlanner.Planner.accept_recipe_suggestion(user, now)
      {:error, "yo", %Umamify.User{id: user_id}, now}
  """
  @spec accept_recipe_suggestion(user_recipe_suggestion_t) :: user_recipe_suggestion_t
  def accept_recipe_suggestion(recipe, user, datetime) do
    {:error, "yo", user, datetime}
  end
end
