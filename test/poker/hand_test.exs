defmodule Poker.HandTest do
  use ExUnit.Case

  test "sort" do
    assert Poker.Hand.sort("White 2C 3H 4S 8C 6H") == %{
             name: "White",
             hand: [{2, :C}, {3, :H}, {4, :S}, {6, :H}, {8, :C}]
           }

    assert Poker.Hand.sort("White TC JH QS KC AH") == %{
             name: "White",
             hand: [{10, :C}, {11, :H}, {12, :S}, {13, :C}, {14, :H}]
           }

    assert Poker.Hand.sort("White TC JH QS KC aH") == %{
             name: "White",
             hand: [{10, :C}, {11, :H}, {12, :S}, {13, :C}, {14, :H}]
           }

    assert Poker.Hand.sort("White 9C 3H 4S 3C 9H") == %{
             name: "White",
             hand: [{3, :H}, {3, :C}, {4, :S}, {9, :C}, {9, :H}]
           }
  end
end
