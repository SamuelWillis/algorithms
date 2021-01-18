defmodule ElixirImpl.Sorting.MergeSortTest do
  use ExUnit.Case

  alias ElixirImpl.Sorting.MergeSort

  describe "sort/1" do
    test "empty list" do
      assert [] == MergeSort.sort([])
    end

    test "single element list" do
      assert [1] == MergeSort.sort([1])
    end

    test "unsorted arrays" do
      for _i <- 0..100 do
        end_list = for _x <- 0..10, do: :rand.uniform(50 - -50) + -50
        sorted = Enum.sort(end_list)
        assert sorted == MergeSort.sort(end_list)
      end
    end
  end
end
