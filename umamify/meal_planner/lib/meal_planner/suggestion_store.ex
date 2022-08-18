defmodule MealPlanner.Mnesiac.SuggestionStore do
  @moduledoc ~S"""
  This module initialize, adds and list Suggestion mnesia record.
  """
  use Mnesiac.Store
  alias MealPlanner.Suggestion

  @impl true
  def store_options do
    [
      record_name: :suggestion,
      attributes: [:user_id, :recipe_id, :day, :period],
      disc_copies: [node()]
    ]
  end

  @impl true
  def resolve_conflict(node) do
    Logger.warn("RESOLVE CONFLICT #{inspect(node())} vs #{inspect(node)}")

    copy_store()
  end

  def get_by_user_id(user_id, datetime) do
  end

  def get_by_trending(geolocation, datetime) do
  end

  def get_by_tags(tags, datetime) do
  end

  def by_geo(geolocation, datetime) do
  end
end
