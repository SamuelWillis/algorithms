defmodule ElixirImpl.SortingTest do
  use ExUnit.Case, async: true

  alias ElixirImpl.Sorting

  describe "insertion_sort/1" do
    test "returns sorted list" do
      result = Sorting.insertion_sort([3, 2, 1])
      assert result == [1, 2, 3]
    end
  end

  describe "merge_sort/1" do
    test "returns sorted list" do
      result = Sorting.merge_sort([3, 2, 1])
      assert result == [1, 2, 3]
    end
  end

  describe "heap_sort/1" do
    test "returns sorted list" do
      result = Sorting.heap_sort([3, 2, 1])
      assert result == [1, 2, 3]
    end
  end
end
