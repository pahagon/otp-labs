defmodule Umamify.User do
  @moduledoc ~S"""
  This module represents an User.
  """
  defstruct id: nil, name: nil, tags: nil

  @typedoc ~S"""
  Type that represents User
  """
  @type t :: %__MODULE__{id: integer(), name: String.t(), tags: list(String.t())}

  @doc ~S"""
  This function check if is an user is valid

  ## Examples
      iex> user = %Umamify.User{id: 1}
      iex> Umamify.User.valid?(user)
      {:ok, user}

      iex> user = %Umamify.User{}
      iex> Umamify.User.valid?(user)
      {:error, "id is nil", user}

      iex> Umamify.User.valid?(nil)
      {:error, "user is nil", nil}
  """
  @spec valid?(__MODULE__.t()) :: {:ok, __MODULE__.t()} | {:error, String.t(), __MODULE__.t()}
  def valid?(user) do
    cond do
      user == nil ->
        {:error, "user is nil", user}

      user != nil ->
        if(Map.get(user, :id) == nil, do: {:error, "id is nil", user}, else: {:ok, user})

      # best pratice
      true ->
        {:error, "Unknown", user}
    end
  end
end
