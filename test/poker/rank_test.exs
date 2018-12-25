defmodule Poker.RankTest do
  use ExUnit.Case

  test "get rank royal_flush" do
    assert Poker.Rank.run([{10, :S}, {11, :S}, {12, :S}, {13, :S}, {14, :S}]) ==
             {:royal_flush, [14]}

    assert Poker.Rank.run([{9, :S}, {11, :S}, {12, :S}, {13, :S}, {14, :S}]) !=
             {:royal_flush, [14]}
  end

  test "get rank straight_flush" do
    assert Poker.Rank.run([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {6, :S}]) == {:straight_flush, [6]}

    assert Poker.Rank.run([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {14, :S}]) ==
             {:straight_flush, [5]}

    assert Poker.Rank.run([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {6, :H}]) != {:straight_flush, [6]}
    assert Poker.Rank.run([{3, :S}, {4, :S}, {5, :S}, {6, :S}, {7, :S}]) == {:straight_flush, [7]}
  end

  test "get rank four_of_a_kind" do
    assert Poker.Rank.run([{2, :C}, {2, :H}, {2, :S}, {2, :D}, {6, :H}]) ==
             {:four_of_a_kind, [2, 6]}

    assert Poker.Rank.run([{1, :C}, {2, :H}, {2, :S}, {2, :D}, {2, :C}]) ==
             {:four_of_a_kind, [2, 1]}
  end

  test "get rank full_house" do
    assert Poker.Rank.run([{2, :C}, {2, :H}, {2, :S}, {9, :D}, {9, :H}]) == {:full_house, [2, 9]}
    assert Poker.Rank.run([{1, :C}, {1, :H}, {2, :S}, {2, :D}, {2, :C}]) == {:full_house, [2, 1]}
    assert Poker.Rank.run([{1, :C}, {5, :H}, {2, :S}, {2, :D}, {2, :C}]) != {:full_house, [1, 2]}
    assert Poker.Rank.run([{1, :C}, {1, :H}, {2, :S}, {2, :D}, {5, :C}]) != {:full_house, [1, 2]}
  end

  test "get rank flush" do
    assert Poker.Rank.run([{2, :H}, {3, :H}, {4, :H}, {5, :H}, {9, :H}]) ==
             {:flush, [2, 3, 4, 5, 9]}

    assert Poker.Rank.run([{1, :S}, {3, :S}, {4, :S}, {5, :S}, {11, :S}]) ==
             {:flush, [1, 3, 4, 5, 11]}

    assert Poker.Rank.run([{1, :C}, {2, :C}, {4, :C}, {5, :C}, {11, :H}]) !=
             {:flush, [1, 2, 4, 5, 11]}
  end

  test "get rank straight" do
    assert Poker.Rank.run([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {6, :S}]) != {:straight, [6]}
    assert Poker.Rank.run([{2, :S}, {3, :S}, {4, :S}, {5, :S}, {14, :S}]) != {:straight, [5]}
    assert Poker.Rank.run([{5, :C}, {6, :H}, {7, :C}, {8, :C}, {9, :H}]) == {:straight, [9]}
    assert Poker.Rank.run([{2, :C}, {3, :H}, {4, :C}, {5, :C}, {14, :H}]) == {:straight, [5]}
  end

  test "get rank three_of_a_kind" do
    assert Poker.Rank.run([{3, :S}, {3, :H}, {4, :S}, {4, :C}, {6, :S}]) !=
             {:three_of_a_kind, [3, 4, 6]}

    assert Poker.Rank.run([{11, :C}, {11, :H}, {11, :S}, {12, :C}, {12, :H}]) !=
             {:three_of_a_kind, [11, 12, 12]}

    assert Poker.Rank.run([{5, :C}, {5, :H}, {5, :S}, {8, :C}, {9, :H}]) ==
             {:three_of_a_kind, [5, 9, 8]}

    assert Poker.Rank.run([{4, :C}, {5, :H}, {5, :S}, {5, :C}, {9, :H}]) ==
             {:three_of_a_kind, [5, 9, 4]}

    assert Poker.Rank.run([{4, :C}, {5, :H}, {6, :S}, {6, :C}, {6, :H}]) ==
             {:three_of_a_kind, [6, 5, 4]}
  end

  test "get rank two_pair" do
    assert Poker.Rank.run([{3, :S}, {3, :H}, {4, :S}, {4, :C}, {4, :H}]) != {:two_pair, [4, 3, 4]}
    assert Poker.Rank.run([{5, :C}, {5, :H}, {6, :S}, {8, :C}, {8, :H}]) == {:two_pair, [8, 5, 6]}
    assert Poker.Rank.run([{4, :C}, {5, :H}, {5, :S}, {6, :C}, {6, :H}]) == {:two_pair, [6, 5, 4]}
    assert Poker.Rank.run([{4, :C}, {4, :H}, {5, :S}, {5, :C}, {6, :H}]) == {:two_pair, [5, 4, 6]}
  end

  test "get rank one_pair" do
    assert Poker.Rank.run([{3, :S}, {3, :H}, {4, :S}, {4, :C}, {5, :H}]) !=
             {:one_pair, [4, 5, 3, 3]}

    assert Poker.Rank.run([{3, :S}, {3, :H}, {4, :S}, {4, :C}, {4, :H}]) !=
             {:one_pair, [4, 4, 3, 3]}

    assert Poker.Rank.run([{5, :C}, {5, :H}, {6, :S}, {8, :C}, {9, :H}]) ==
             {:one_pair, [5, 9, 8, 6]}

    assert Poker.Rank.run([{4, :C}, {5, :H}, {5, :S}, {6, :C}, {7, :H}]) ==
             {:one_pair, [5, 7, 6, 4]}

    assert Poker.Rank.run([{4, :C}, {8, :H}, {9, :S}, {12, :C}, {12, :H}]) ==
             {:one_pair, [12, 9, 8, 4]}
  end

  test "get rank high_card" do
    assert Poker.Rank.run([{3, :S}, {3, :H}, {4, :S}, {4, :C}, {5, :H}]) !=
             {:high_card, [5, 4, 4, 3, 3]}

    assert Poker.Rank.run([{3, :S}, {4, :H}, {5, :S}, {6, :C}, {6, :H}]) !=
             {:high_card, [6, 6, 5, 4, 3]}

    assert Poker.Rank.run([{5, :C}, {6, :H}, {7, :S}, {8, :C}, {11, :H}]) ==
             {:high_card, [11, 8, 7, 6, 5]}
  end
end
