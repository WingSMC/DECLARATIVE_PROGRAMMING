defmodule DeclaTest do
  use ExUnit.Case
  doctest Decla

  test "generate_directions puts tents at the correct place" do
    assert Nhf1.generate_directions(
      [{1,2}, {2,1}, {2,3}, {3,2}],
      [{1,1}, {1,3}, {3,1}, {3,3}]
    ) === [[:e, :n, :s, :w], [:w, :s, :n, :e]]


    assert Nhf1.generate_directions(
      [],
      [{1,1}, {1,3}, {3,1}, {3,3}]
    ) === []


    assert Nhf1.generate_directions(
      [{1,1}, {2,2}, {3,3}],
      [{2,1}, {2,3}, {1,2}]
    ) === [[:e, :w, :n], [:s, :n, :n]]
  end
end
