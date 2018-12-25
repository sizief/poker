defmodule Poker.Judge do
  @moduledoc """
  As name of this module implies, it will tell who is the winner between two sets of Poker.Hand
  """

  @doc """
  evaluate

  ## Examples

      iex> Poker.Judge.evaluate(
        %{name: "white", hand: [{3,:H}, {4,:H}, {5,:S}, {6,:C}, {9,:H}]},
        %{name: "black", hand: [{2,:H}, {3,:C}, {4,:S}, {9,:C}, {10,:H}]})
      )
      {"black", "High card: 10"}

  """
  def evaluate(player_one_hand, player_two_hand) do
    [player_one, player_two] =
      Enum.map(
        [
          {Poker.Rank.run(player_one_hand[:hand]), player_one_hand},
          {Poker.Rank.run(player_two_hand[:hand]), player_two_hand}
        ],
        fn rank ->
          {rank |> elem(0) |> elem(0) |> get_value, rank |> elem(0) |> elem(1),
           elem(rank, 1)[:name], rank |> elem(0) |> elem(0)}
        end
      )

    winner(player_one, player_two)
  end

  def get_value(suit) do
    case suit do
      :royal_flush -> 10
      :straight_flush -> 9
      :four_of_a_kind -> 8
      :full_house -> 7
      :flush -> 6
      :straight -> 5
      :three_of_a_kind -> 4
      :two_pair -> 3
      :one_pair -> 2
      :high_card -> 1
    end
  end

  # Input is {rank_value, hand, name, rank} and output is {name, rank}
  defp winner({a, _, c, d}, {e, _, g, h}) when a != e,
    do: if(a > e, do: {c, stringify(d)}, else: {g, stringify(h)})

  defp winner({_, b, c, _}, {_, f, g, _}) when b != f do
    res = is_greater(b, f)

    if elem(res, 0) do
      {c, "High card: #{number_to_char(elem(res, 1))}"}
    else
      {g, "High card: #{number_to_char(elem(res, 1))}"}
    end
  end

  defp winner({_, _, _, _}, {_, _, _, _}), do: {"tie"}

  defp is_greater(a, b) do
    case hd(a) == hd(b) do
      true -> is_greater(tl(a), tl(b))
      false when hd(a) > hd(b) -> {true, hd(a)}
      _ -> {false, hd(b)}
    end
  end

  defp stringify(suit), do: Atom.to_string(suit) |> String.replace("_", " ")

  defp number_to_char(10), do: "T"
  defp number_to_char(11), do: "J"
  defp number_to_char(12), do: "Q"
  defp number_to_char(13), do: "K"
  defp number_to_char(14), do: "A"
  defp number_to_char(x), do: x
end
