defmodule MealPlanner.Recipe do
  @moduledoc ~S"""
  This module represents Recipe.
  """

  defstruct id: nil, title: nil, instructions: nil, ingredients: nil

  alias MealPlanner.Recipe.Ingredient

  @typedoc ~S"""
  Type that represents Recipe.
  """
  @type t :: %__MODULE__{
          id: integer(),
          title: String.t(),
          instructions: String.t(),
          ingredients: list(Ingredient.t())
        }

  @doc ~S"""
  This function check if is a recipe is valid

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Ingredient{name: "pasta", quantity: 0.1, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Ingredient{name: "chicken", quantity: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{id: 1, title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Recipe.valid?(recipe)
      {:ok, recipe}

      iex> item_1 = %MealPlanner.Recipe.Ingredient{}
      iex> item_2 = %MealPlanner.Recipe.Ingredient{name: "chicken", quantity: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{id: 1, title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Recipe.valid?(recipe)
      {:error, "There are/is itens with error", recipe}

      iex> recipe = %MealPlanner.Recipe{}
      iex> MealPlanner.Recipe.valid?(recipe)
      {:error, "title is nil, instructions is nil, ingredients is nil, id is nil", recipe}

      iex> MealPlanner.Recipe.valid?(nil)
      {:error, "recipe is nil", nil}
  """
  @spec valid?(__MODULE__.t()) :: {:ok, __MODULE__.t()} | {:error, String.t(), __MODULE__.t()}
  def valid?(recipe) do
    cond do
      recipe == nil ->
        {:error, "recipe is nil", nil}

      recipe != nil ->
        nil_attrs = filter_nil_attrs(recipe)

        if Enum.empty?(nil_attrs) do
          case Ingredient.any_invalid?(recipe.ingredients) do
            {:error, _items} ->
              {:error, "There are/is itens with error", recipe}

            _ ->
              {:ok, recipe}
          end
        else
          {:error, Enum.join(nil_attrs, ", "), recipe}
        end

      # best pratice
      true ->
        {:error, "Unknown", recipe}
    end
  end

  defp filter_nil_attrs(recipe) do
    recipe
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce(
      [],
      fn attr, acc ->
        value = Map.get(recipe, attr)

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
