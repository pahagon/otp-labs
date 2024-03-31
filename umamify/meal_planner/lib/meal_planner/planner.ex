defmodule MealPlanner.Planner do
  @moduledoc ~S"""
  This module is used for make meal suggestion.
  """

  alias Umamify.User
  alias Umamify.Geolocation

  alias MealPlanner.Suggestion
  alias MealPlanner.Mnesia.SuggestionStore, as: SuggStore

  @spec make_suggestion(User.t(), Geolocation.t(), Timex.DateTime.t()) :: Suggestion.t()
  def make_suggestion(user, geo, datetime) do
    %User{id: user_id, tags: tags} = user

    with {:suggestion_not_found, :by_user_id} <- SuggStore.get_by_user_id(user_id, datetime),
         {:suggestion_not_found, :by_tags} <- SuggStore.get_by_tags(tags, datetime),
         {:suggestion_not_found, :by_trending} <- SuggStore.get_by_trending(geo, datetime),
         {:suggestion_found, :by_geo, suggestion} <- SuggStore.by_geo(geo, datetime) do
      suggestion
    else
      {:suggestion_found, :by_user_id, suggestion} -> suggestion
      {:suggestion_found, :by_trending, suggestion} -> suggestion
      {:suggestion_found, :by_tag, suggestion} -> suggestion
      {:suggestion_not_found, :by_geo} -> default(geo, datetime)
    end
  end

  @spec default(Geolocation.t(), Timex.DateTime.t()) :: Suggestion.t()
  def default(_geo, _datetime) do
  end

  def refuse_suggestion(suggestion, user, geo, datetime) do
    %User{id: user_id, tags: tags} = user
    SuggStore.refuse(suggestion, user_id, tags, geo, datetime)
  end
end
