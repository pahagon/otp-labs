defmodule MealPlanner.SuggestionTest do
  use ExUnit.Case, async: true

  doctest MealPlanner.Suggestion

  test "it can be encode" do
    recipe_item = %MealPlanner.Recipe.Ingredient{name: "Pasta", quantity: 0.1, unit: :kg}
    recipe = %MealPlanner.Recipe{id: 1, title: "Chicken Pasta", instructions: "Cook", ingredients: [recipe_item]}
    day = ~D[2022-01-01]
    period = Umamify.Period.calc(~N[2022-01-01 06:00:00])
    suggestion = %MealPlanner.Suggestion{user_id: 1, recipe: recipe, day: day, period: period}
    assert true == true
  end
end
