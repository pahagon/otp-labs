defmodule MealPlanner.Mnesiac.RecipeStore do
  @moduledoc ~S"""
  This module initialize, adds and list Recipe mnesia record.
  """
  use Mnesiac.Store
  alias MealPlanner.Recipe

  @impl true
  def store_options do
    [
      record_name: :recipe,
      attributes: [:id, :title, :instructions, :ingredients],
      disc_copies: [node()]
    ]
  end

  @impl true
  def resolve_conflict(node) do
    Logger.warning("RESOLVE CONFLICT #{inspect(node())} vs #{inspect(node)}")

    copy_store()
  end

  @type recipe_record_t :: {:recipe, integer(), String.t(), String.t(), list(Recipe.Ingredient.t())}

  @doc ~S"""
  Serialization
  """
  @spec decode(recipe_record_t) :: Recipe.t()
  def decode({:recipe, id, title, instructions, ingredients}) do
    %Recipe{id: id, title: title, instructions: instructions, ingredients: ingredients}
  end

  @doc ~S"""
  Deserialization
  """
  @spec encode(Recipe.t()) :: recipe_record_t
  def encode(%Recipe{id: id, title: title, instructions: instructions, ingredients: ingredients}) do
    {:recipe, id, title, instructions, ingredients}
  end

  @doc ~S"""
  This function create a recipe.

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Ingredient{name: "pasta", quantity: 0.1, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Ingredient{name: "chicken", quantity: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{id: 1, title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Mnesiac.RecipeStore.create(recipe)
      :ok
  """
  @spec create(Recipe.t()) :: :ok | {:error, any()}
  def create(%Recipe{id: id} = recipe) when is_integer(id) do
    :mnesia.transaction(fn ->
      case :mnesia.read(:recipe, id, :write) do
        [] ->
          recipe |> encode() |> :mnesia.write()

        _ ->
          :record_exists
      end
    end)
    |> case do
      {:atomic, :ok} -> :ok
      {:atomic, :record_exists} -> :ok
      {:aborted, reason} -> {:error, reason}
    end
  end

  @doc ~S"""
  This function list persisted recipes.

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Ingredient{name: "pasta", quantity: 0.1, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Ingredient{name: "chicken", quantity: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{id: 2, title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Mnesiac.RecipeStore.create(recipe)
      iex> MealPlanner.Mnesiac.RecipeStore.list() |> Enum.filter(&(&1.id == 2))
      [
        %MealPlanner.Recipe{
          id: 2,
          ingredients: [
            %MealPlanner.Recipe.Ingredient{name: "pasta", quantity: 0.1, unit: :kg},
            %MealPlanner.Recipe.Ingredient{name: "chicken", quantity: 0.3, unit: :kg}
          ],
          instructions: "Cookie",
          title: "Chicken Pasta"
        }
      ]
  """
  @spec list() :: list(Recipe.t()) | []
  def list() do
    :mnesia.transaction(fn ->
      :mnesia.match_object({:recipe, :_, :_, :_, :_})
    end)
    |> case do
      {:atomic, list} -> Enum.map(list, &decode(&1))
      {:aborted, {:no_exists, :recipe}} -> []
    end
  end
end
