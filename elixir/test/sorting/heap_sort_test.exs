defmodule ElixirImpl.Sorting.HeapSortTest do
  use ExUnit.Case
  alias ElixirImpl.Sorting.HeapSort

  doctest ElixirImpl.Sorting.HeapSort

  describe "sort/1" do
    test "empty list" do
      assert [] == HeapSort.sort([])
    end

    test "single element list" do
      assert [1] == HeapSort.sort([1])
    end

    test "unsorted arrays" do
      for _i <- 0..100 do
        end_list = for _x <- 0..10, do: :rand.uniform(50 - -50) + -50
        sorted = Enum.sort(end_list)
        assert sorted == HeapSort.sort(end_list)
      end
    end
  end
end
