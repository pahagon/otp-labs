defmodule MealPlanner.Recipe.WebScraper.TudoGostoso do
  def fetch_recipe_details(url) do
    #url = "https://www.tudogostoso.com.br/receita/96259-fraldinha-de-panela.html"
    headers = [
      {"User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36"},
      {'accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7'},
      {'accept-language', ' pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7'},
      {'cache-control', ' max-age=0'},
      {'referer', ' https://www.tudogostoso.com.br/receita/96259-fraldinha-de-panela.html'},
      {'sec-ch-ua', ' "Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"'},
      {'sec-ch-ua-mobile', ' ?0'},
      {'sec-ch-ua-platform', ' "Linux"'},
      {'sec-fetch-dest', ' document'},
      {'sec-fetch-mode', ' navigate'},
      {'sec-fetch-site', ' same-origin'},
      {'sec-fetch-user', ' ?1'},
      {'upgrade-insecure-requests', ' 1'},
    ]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_html(body)
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Erro ao acessar a página: #{reason}")
    end
  end

  def from_file(file_path) do
    file_path
    |> File.read!()
    |> parse_html()
  end

  defp parse_html(html) do
    case Floki.parse_document(html) do
      {:ok, document} ->
        extract_recipe_details(document)
      {:error, error} ->
        {:error, error}
    end
  end

  defp extract_recipe_details(document) do
    #document
    #|> Floki.find("script")
    #|> Floki.find("text/javascript")
    #|> IO.inspect()

    title = document
    |> Floki.find("h1")
    |> Floki.text()
    |> String.trim()

    instructions = document
    |> Floki.find(".recipe-steps-text")
    |> Floki.text()
    |> String.trim()

    ingredients = document
    |> Floki.find(".recipe-ingredients")
    |> Floki.find("li")
    |> Enum.map(&Floki.text/1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.replace(&1, ~r/\s{2,}/, " "))
    |> Enum.map(&String.replace(&1, ~r/\n/, ""))
    |> Enum.map(&String.replace(&1, ~r/\r/, ""))
    |> Enum.map(&String.replace(&1, ~r/\t/, ""))
    |> Enum.map(&String.replace(&1, ~r/\s{2,}/, " "))
    |> Enum.map(&String.trim/1)
    |> Enum.map(&(%MealPlanner.Recipe.Ingredient{name: &1}))

    %MealPlanner.Recipe{
      title: title,
      instructions: instructions,
      ingredients: ingredients
    }
  end
end
