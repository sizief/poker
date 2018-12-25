defmodule Poker.Rank do
  @moduledoc """
  This module ُgive ranks output of Poker.Hand.
  """

  @doc """
  run

  ## Examples

      iex> Poker.Rank.run([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {6, :S}])
      {:straight_flush, [6]}

  """
  def run(cards) do
    get_rank(cards)
  end

  # royal_flush
  defp get_rank([{10, :S}, {11, :S}, {12, :S}, {13, :S}, {14, :S}]), do: {:royal_flush, [14]}

  # straight_flush
  defp get_rank([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {14, :S}]), do: {:straight_flush, [5]}

  defp get_rank([{a, :S}, {_b, :S}, {_c, :S}, {_d, :S}, {e, :S}]) when e - a == 4,
    do: {:straight_flush, [e]}

  # four_of_a_kind
  defp get_rank([{a, _}, {a, _}, {a, _}, {a, _}, {b, _}]), do: {:four_of_a_kind, [a, b]}
  defp get_rank([{a, _}, {b, _}, {b, _}, {b, _}, {b, _}]), do: {:four_of_a_kind, [b, a]}

  # full_house
  defp get_rank([{a, _}, {a, _}, {a, _}, {b, _}, {b, _}]), do: {:full_house, [a, b]}
  defp get_rank([{a, _}, {a, _}, {b, _}, {b, _}, {b, _}]), do: {:full_house, [b, a]}

  # flush
  defp get_rank([{a, x}, {b, x}, {c, x}, {d, x}, {e, x}]), do: {:flush, [a, b, c, d, e]}

  # straight
  defp get_rank([{a, _}, {b, _}, {c, _}, {d, _}, {e, _}])
       when a + 1 == b and b + 1 == c and c + 1 == d and d + 1 == e,
       do: {:straight, [e]}

  defp get_rank([{2, _}, {3, _}, {4, _}, {5, _}, {14, _}]), do: {:straight, [5]}

  # three_of_a_kind
  defp get_rank([{a, _}, {a, _}, {a, _}, {b, _}, {c, _}]), do: {:three_of_a_kind, [a, c, b]}
  defp get_rank([{a, _}, {b, _}, {b, _}, {b, _}, {c, _}]), do: {:three_of_a_kind, [b, c, a]}
  defp get_rank([{a, _}, {b, _}, {c, _}, {c, _}, {c, _}]), do: {:three_of_a_kind, [c, b, a]}

  # two_pair
  defp get_rank([{a, _}, {a, _}, {b, _}, {b, _}, {c, _}]), do: {:two_pair, [b, a, c]}
  defp get_rank([{a, _}, {b, _}, {b, _}, {c, _}, {c, _}]), do: {:two_pair, [c, b, a]}
  defp get_rank([{a, _}, {a, _}, {b, _}, {c, _}, {c, _}]), do: {:two_pair, [c, a, b]}

  # one_pair
  defp get_rank([{a, _}, {a, _}, {b, _}, {c, _}, {d, _}]), do: {:one_pair, [a, d, c, b]}
  defp get_rank([{a, _}, {b, _}, {b, _}, {c, _}, {d, _}]), do: {:one_pair, [b, d, c, a]}
  defp get_rank([{a, _}, {b, _}, {c, _}, {c, _}, {d, _}]), do: {:one_pair, [c, d, b, a]}
  defp get_rank([{a, _}, {b, _}, {c, _}, {d, _}, {d, _}]), do: {:one_pair, [d, c, b, a]}

  # high_card
  defp get_rank([{a, _}, {b, _}, {c, _}, {d, _}, {e, _}]), do: {:high_card, [e, d, c, b, a]}
end
