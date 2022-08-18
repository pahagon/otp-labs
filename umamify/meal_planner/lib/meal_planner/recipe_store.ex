defmodule MealPlanner.Mnesiac.RecipeStore do
  @moduledoc ~S"""
  Provides the structure of Menesia records.
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
    Logger.warn("RESOLVE CONFLICT #{inspect(node())} vs #{inspect(node)}")

    copy_store()
  end

  @doc ~S"""
  Serialization
  """
  def decode({:recipe, id, title, instructions, ingredients}) do
    %Recipe{id: id, title: title, instructions: instructions, ingredients: ingredients}
  end

  @doc ~S"""
  Deserialization
  """
  def encode(%Recipe{id: id, title: title, instructions: instructions, ingredients: ingredients}) do
    {:recipe, id, title, instructions, ingredients}
  end

  @doc ~S"""
  This function create a recipe.

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Item{name: "pasta", qty: 0.1, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Item{name: "chicken", qty: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{id: 1, title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Mnesiac.RecipeStore.create(recipe)
      :ok
  """
  def create(%Recipe{id: id} = state) when is_integer(id) do
    {:atomic, reason} =
      :mnesia.transaction(fn ->
        case :mnesia.read(:recipe, id, :write) do
          [] ->
            state |> encode() |> :mnesia.write()

          _ ->
            :record_exists
        end
      end)

    reason
  end

  @doc ~S"""
  This function list persisted recipes.

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Item{name: "pasta", qty: 0.1, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Item{name: "chicken", qty: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{id: 2, title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Mnesiac.RecipeStore.create(recipe)
      iex> MealPlanner.Mnesiac.RecipeStore.list()
      [
        %MealPlanner.Recipe{
          id: 2,
          ingredients: [
            %MealPlanner.Recipe.Item{name: "pasta", qty: 0.1, unit: :kg},
            %MealPlanner.Recipe.Item{name: "chicken", qty: 0.3, unit: :kg}
          ],
          instructions: "Cookie",
          title: "Chicken Pasta"
        }
      ]
  """
  def list() do
    :mnesia.transaction(fn ->
      :mnesia.match_object({:recipe, :_, :_, :_, :_})
    end)
    |> case do
      {:atomic, list} -> Enum.map(list, &decode(&1))
      {:aborted, {:no_exists, MealPlanner.Recipe}} -> []
    end
  end
end
