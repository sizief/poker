defmodule Poker do
  @moduledoc """
  Documentation for Poker.
  """

  @doc """
  run

  ## Examples

      iex> Poker.run("white 2S 3H 4S 8C 6H", "black 2S 2H 4S 8C 6H")
      {"black", "one pair"}

  """
  def run(first_hand, second_hand) do
    Poker.Judge.evaluate(
      Poker.Hand.sort(first_hand),
      Poker.Hand.sort(second_hand)
    )
  end
end
