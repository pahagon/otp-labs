defmodule MealPlanner.Recipe.Item do
  @moduledoc false
  defstruct name: nil, qty: nil, unit: nil

  @typedoc ~S"""
  Type that represents Recipe Item
  """
  @type t :: %__MODULE__{name: String.t(), qty: float(), unit: atom()}

  @doc ~S"""
  This function check if is an item is valid

  ## Examples
      iex> r_item = %MealPlanner.Recipe.Item{name: "meat", qty: 1.0, unit: :kg}
      iex> MealPlanner.Recipe.Item.valid?(r_item)
      {:ok, r_item}

      iex> r_item = %MealPlanner.Recipe.Item{}
      iex> MealPlanner.Recipe.Item.valid?(r_item)
      {:error, "unit is nil, qty is nil, name is nil", r_item}

      iex> r_item = %MealPlanner.Recipe.Item{qty: 1.0, unit: :kg}
      iex> MealPlanner.Recipe.Item.valid?(r_item)
      {:error, "name is nil", r_item}

      iex> r_item = %MealPlanner.Recipe.Item{name: "", qty: 1.0, unit: :kg}
      iex> MealPlanner.Recipe.Item.valid?(r_item)
      {:error, "name is empty", r_item}

      iex> MealPlanner.Recipe.Item.valid?(nil)
      {:error, "item is nil", nil}
  """
  @spec valid?(__MODULE__.t()) :: {:ok, __MODULE__.t()} | {:error, String.t(), __MODULE__.t()}
  def valid?(item) do
    cond do
      item == nil ->
        {:error, "item is nil", nil}

      item != nil ->
        nil_attrs = filter_nil_attrs(item)

        nil_attrs
        |> Enum.empty?()
        |> if(do: {:ok, item}, else: {:error, Enum.join(nil_attrs, ", "), item})

      # best pratice
      true ->
        {:error, "Unknown", item}
    end
  end

  defp filter_nil_attrs(item) do
    item
    |> Map.keys()
    |> Enum.reduce(
      [],
      fn attr, acc ->
        value = Map.get(item, attr)

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

  @doc ~S"""
  This function check if is an item is valid

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Item{name: "meat", qty: 1.0, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Item{name: "chicken", qty: 2.0, unit: :kg}
      iex> MealPlanner.Recipe.Item.any_invalid?([item_1, item_2])
      {:ok, [item_1, item_2]}

      iex> item_3 = %MealPlanner.Recipe.Item{}
      iex> MealPlanner.Recipe.Item.any_invalid?([item_3])
      {:error, [item_3]}
  """
  @spec any_invalid?(list(__MODULE__.t())) ::
          {:ok, list(__MODULE__.t())} | {:error, list(__MODULE__.t())}
  def any_invalid?(items) do
    item =
      Enum.find(
        items,
        fn item ->
          case valid?(item) do
            {:error, _msg, _item} ->
              true

            _ ->
              false
          end
        end
      )

    if is_nil(item) do
      {:ok, items}
    else
      {:error, items}
    end
  end
end

defmodule MealPlanner.Recipe do
  @moduledoc false
  defstruct title: nil, instructions: nil, ingredients: nil

  alias MealPlanner.Recipe.Item

  @typedoc ~S"""
  Type that represents Recipe
  """
  @type t :: %__MODULE__{title: String.t(), instructions: String.t(), ingredients: list(Item.t())}

  @doc ~S"""
  This function check if is a recipe is valid

  ## Examples
      iex> item_1 = %MealPlanner.Recipe.Item{name: "pasta", qty: 0.1, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Item{name: "chicken", qty: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Recipe.valid?(recipe)
      {:ok, recipe}

      iex> item_1 = %MealPlanner.Recipe.Item{}
      iex> item_2 = %MealPlanner.Recipe.Item{name: "chicken", qty: 0.3, unit: :kg}
      iex> itens = [item_1, item_2]
      iex> recipe = %MealPlanner.Recipe{title: "Chicken Pasta", instructions: "Cookie", ingredients: itens}
      iex> MealPlanner.Recipe.valid?(recipe)
      {:error, "There are/is itens with error", recipe}

      iex> recipe = %MealPlanner.Recipe{}
      iex> MealPlanner.Recipe.valid?(recipe)
      {:error, "title is nil, instructions is nil, ingredients is nil", recipe}

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
          case Item.any_invalid?(recipe.ingredients) do
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
