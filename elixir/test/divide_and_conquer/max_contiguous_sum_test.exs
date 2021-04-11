defmodule ElixirImpl.DivideAndConquer.MaxContiguousSumTest do
  use ExUnit.Case, async: true

  alias ElixirImpl.DivideAndConquer.MaxContiguousSum

  describe "find/1" do
    test "returns correct for empty list" do
    end

    test "returns correct for single element" do
      assert 10 == MaxContiguousSum.find([10])
    end

    test "returns max contiguous sum in first half of array" do
      list = [1, 2, 3, -10, -10, -10]

      assert 6 == MaxContiguousSum.find(list)
    end

    test "returns max contiguous sum in second half of array" do
      list = [-10, -10, -10, 1, 2, 3]

      assert 6 == MaxContiguousSum.find(list)
    end

    test "returns max contiguous sum crossing midpoint of array" do
      list = [-10, -10, 1, 2, 3, -10, -10]

      assert 6 == MaxContiguousSum.find(list)
    end

    test "randomized tests" do
      for i <- 0..50 do
        left_list = for _i <- 0..Enum.random(0..10), do: -1
        right_list = for _i <- 0..Enum.random(0..10), do: -1

        list = left_list ++ [1, 2, 3] ++ right_list

        assert 6 == MaxContiguousSum.find(list)
      end
    end
  end
end
