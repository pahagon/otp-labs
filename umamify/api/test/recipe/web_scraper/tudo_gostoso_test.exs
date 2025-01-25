defmodule MealPlanner.Recipe.WebScraper.TudoGostosoTest do
  use ExUnit.Case, async: true

  doctest MealPlanner.Recipe.WebScraper.TudoGostoso

  test "scrape recipe" do
    recipe = MealPlanner.Recipe.WebScraper.TudoGostoso.from_file("/home/pahagon/Development/otp-labs/umamify/meal_planner/test/fixtures/fraldinha.html");
    assert recipe == %MealPlanner.Recipe{
      title: "Fraldinha de panela",
      instructions: "Compre uma peça de fraldinha de aproximadamente 1,3 kg e limpe muito bem.Tempere com sal fino e reserve.Em uma panela de pressão coloque 1 fio de azeite, a peça de fraldinha com a gordura virada para baixo, cubra a carne com as rodelas de cebola.Salpique pimenta calabresa, pimenta-do-reino moída na hora, alho espremido, sal fino e regue com o azeite restante. Não coloque nada de água.Depois é só tampar a panela e levar ao fogo alto e contar 35 minutos após a panela pegar pressão.Espere a pressão sair completamente, retire as rodelas de cebola, com cuidado, fatie a carne e coloque em uma travessa. Cubra a carne com as rodelas de cebola cozidas e com o caldo que sobrou na panela e sirva com arroz branco e uma bela salada de folha.",
      ingredients: [
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "1 peça de fraldinha ou picanha"},
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "3 cebolas grandes, em rodelas"},
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "1 colher, das de sobremesa, de sal fino"},
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "Pimenta-do-reino a gosto"},
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "Pimenta calabresa a gosto"},
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "3 colheres, das de sopa, de azeite"},
        %MealPlanner.Recipe.Ingredient{quantity: nil, unit: nil, name: "3 dentes de alho, amassados"},
      ],
    }
  end
end
