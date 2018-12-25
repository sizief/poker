defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "run" do
    # assert Poker.run("white 2S 3H 4S 8C 6H", "black 2S 3H 4S 8C 6H") == {"tie"}
    # assert Poker.run("white 2S 3H 4S 8C 6H", "black 2S 2H 4S 8C 6H") == {"black", "one pair"}
  end
end
