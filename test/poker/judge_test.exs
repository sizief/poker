defmodule Poker.JudgeTest do
  use ExUnit.Case

  test "get_value" do
    assert Poker.Judge.get_value(:royal_flush) == 10
    assert Poker.Judge.get_value(:full_house) == 7
    assert Poker.Judge.get_value(:high_card) == 1
  end

  test "evaluate" do
    assert Poker.Judge.evaluate(
             %{name: "white", hand: [{3, :H}, {3, :C}, {4, :S}, {9, :C}, {9, :H}]},
             %{name: "black", hand: [{3, :H}, {3, :C}, {4, :S}, {8, :C}, {9, :H}]}
           ) == {"white", "two pair"}

    assert Poker.Judge.evaluate(
             %{name: "White", hand: [{3, :H}, {3, :C}, {4, :S}, {9, :C}, {9, :H}]},
             %{name: "black", hand: [{3, :H}, {3, :C}, {3, :S}, {3, :C}, {9, :H}]}
           ) == {"black", "four of a kind"}

    assert Poker.Judge.evaluate(
             %{name: "White", hand: [{3, :D}, {3, :C}, {4, :S}, {9, :C}, {9, :H}]},
             %{name: "black", hand: [{3, :H}, {3, :S}, {7, :S}, {9, :C}, {9, :H}]}
           ) == {"black", "High card: 7"}

    assert Poker.Judge.evaluate(
             %{name: "White", hand: [{3, :H}, {4, :C}, {5, :S}, {8, :C}, {10, :H}]},
             %{name: "black", hand: [{4, :H}, {7, :C}, {8, :S}, {9, :C}, {11, :H}]}
           ) == {"black", "High card: J"}

    assert Poker.Judge.evaluate(
             %{name: "White", hand: [{3, :S}, {3, :D}, {4, :S}, {9, :S}, {9, :H}]},
             %{name: "black", hand: [{3, :H}, {3, :C}, {4, :H}, {9, :C}, {9, :D}]}
           ) == {"tie"}

    assert Poker.Judge.evaluate(
             %{name: "white", hand: [{3, :H}, {3, :C}, {3, :S}, {9, :C}, {9, :H}]},
             %{name: "black", hand: [{4, :H}, {7, :C}, {7, :S}, {9, :C}, {9, :H}]}
           ) == {"white", "full house"}

    assert Poker.Judge.evaluate(
             %{name: "White", hand: [{3, :H}, {3, :C}, {4, :S}, {9, :C}, {9, :H}]},
             %{name: "black", hand: [{7, :H}, {8, :H}, {4, :H}, {9, :H}, {11, :H}]}
           ) == {"black", "flush"}

    assert Poker.Judge.evaluate(
             %{name: "white", hand: [{2, :H}, {3, :C}, {4, :S}, {5, :C}, {14, :H}]},
             %{name: "black", hand: [{7, :H}, {7, :C}, {4, :S}, {9, :C}, {9, :H}]}
           ) == {"white", "straight"}

    assert Poker.Judge.evaluate(
             %{name: "white", hand: [{2, :H}, {3, :C}, {4, :S}, {6, :C}, {8, :H}]},
             %{name: "black", hand: [{2, :H}, {2, :C}, {4, :S}, {6, :C}, {8, :H}]}
           ) == {"black", "one pair"}
  end
end
