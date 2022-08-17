defmodule MealPlanner.RecipeTest do
  use ExUnit.Case, async: true

  doctest MealPlanner.Recipe
  doctest MealPlanner.Recipe.Item
  doctest MealPlanner.Mnesiac.RecipeStore
end
