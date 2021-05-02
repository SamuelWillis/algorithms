defmodule ElixirImpl.Sorting.InsertionSortTest do
  use ExUnit.Case

  alias ElixirImpl.Sorting.InsertionSort

  doctest ElixirImpl.Sorting.InsertionSort

  describe "sort/1" do
    test "empty list" do
      assert [] == InsertionSort.sort([])
    end

    test "single element list" do
      assert [1] == InsertionSort.sort([1])
    end

    test "two element list" do
      assert [1, 2] == InsertionSort.sort([2, 1])
    end

    test "unsorted arrays" do
      for _i <- 0..100 do
        end_list = for _x <- 0..100, do: :rand.uniform(50 - -50) + -50
        sorted = Enum.sort(end_list)
        assert sorted == InsertionSort.sort(end_list)
      end
    end
  end
end
