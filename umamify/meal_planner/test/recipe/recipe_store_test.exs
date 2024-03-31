defmodule MealPlanner.RecipeRepoTest do
  use ExUnit.Case

  setup do
    :mnesia.clear_table(:recipes)
    :ok
  end

  doctest MealPlanner.Mnesiac.RecipeStore
end
