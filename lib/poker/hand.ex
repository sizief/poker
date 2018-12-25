defmodule Poker.Hand do
  @moduledoc """
  This module convert input string into map
  Call sort on this module with input like "Name_of_the_player 2C 3H 4S 8C 6H"
  """

  @doc """
  sort

  ## Examples

      iex> Poker.Hand.sort("Name_of_the_player 2C 3H 4S 8C 6H")
      %{name: "Name_of_the_player", hand: [{2,:C}, {3,:H}, {4,:S}, {6,:H}, {8,:C}]}

  """
  def sort(cards) do
    list = prepare(cards)
    Map.put(list, :hand, list[:hand] |> List.keysort(0))
  end

  defp prepare(cards) do
    list = cards |> String.split(" ")

    %{
      name: hd(list),
      hand:
        Enum.map(
          tl(list),
          fn x ->
            {x |> String.at(0) |> String.upcase() |> char_to_number |> String.to_integer(),
             x |> String.at(1) |> String.to_atom()}
          end
        )
    }
  end

  defp char_to_number("T"), do: "10"
  defp char_to_number("J"), do: "11"
  defp char_to_number("Q"), do: "12"
  defp char_to_number("K"), do: "13"
  defp char_to_number("A"), do: "14"
  defp char_to_number(x), do: x
end
