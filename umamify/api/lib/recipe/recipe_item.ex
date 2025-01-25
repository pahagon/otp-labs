defmodule MealPlanner.Recipe.Ingredient do
  @moduledoc ~S"""
  This module represents Recipe.Ingredient.
  """

  defstruct name: nil, quantity: nil, unit: nil

  @typedoc ~S"""
  Type that represents Recipe.Ingredient.
  """
  @type t :: %__MODULE__{name: String.t(), quantity: float(), unit: atom()}

  @doc ~S"""
  This function check if is an item is valid

  ## Examples
      iex> r_item = %MealPlanner.Recipe.Ingredient{name: "meat", quantity: 1.0, unit: :kg}
      iex> MealPlanner.Recipe.Ingredient.valid?(r_item)
      {:ok, r_item}

      iex> r_item = %MealPlanner.Recipe.Ingredient{}
      iex> MealPlanner.Recipe.Ingredient.valid?(r_item)
      {:error, "unit is nil, quantity is nil, name is nil", r_item}

      iex> r_item = %MealPlanner.Recipe.Ingredient{quantity: 1.0, unit: :kg}
      iex> MealPlanner.Recipe.Ingredient.valid?(r_item)
      {:error, "name is nil", r_item}

      iex> r_item = %MealPlanner.Recipe.Ingredient{name: "", quantity: 1.0, unit: :kg}
      iex> MealPlanner.Recipe.Ingredient.valid?(r_item)
      {:error, "name is empty", r_item}

      iex> MealPlanner.Recipe.Ingredient.valid?(nil)
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
    |> Enum.sort()
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
      iex> item_1 = %MealPlanner.Recipe.Ingredient{name: "meat", quantity: 1.0, unit: :kg}
      iex> item_2 = %MealPlanner.Recipe.Ingredient{name: "chicken", quantity: 2.0, unit: :kg}
      iex> MealPlanner.Recipe.Ingredient.any_invalid?([item_1, item_2])
      {:ok, [item_1, item_2]}

      iex> item_3 = %MealPlanner.Recipe.Ingredient{}
      iex> MealPlanner.Recipe.Ingredient.any_invalid?([item_3])
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
