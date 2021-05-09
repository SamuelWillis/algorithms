defmodule ElixrImpl.DataStructure.Heap.GuardsTest do
  use ExUnit.Case, async: true

  require ElixirImpl.DataStructure.Heap.Guards

  alias ElixirImpl.DataStructure.Heap
  alias ElixirImpl.DataStructure.Heap.Guards

  @heap Heap.new()

  describe "is_empty/1" do
    test "returns true for empty heap" do
      assert Guards.is_empty(@heap)
    end

    test "returns false for non empty" do
      heap = Heap.push(@heap, 1)
      refute Guards.is_empty(heap)
    end
  end

  describe "is_heap/1" do
    test "returns true for heap" do
      assert Guards.is_heap(@heap)
    end

    test "returns false for non heap" do
      refute Guards.is_heap(%{})
    end
  end

  describe "is_leaf/1" do
    test "returns true for leaf" do
      assert Guards.is_leaf(@heap)
    end

    test "returns false for non leaf" do
      heap = Heap.push(@heap, 1)
      assert Guards.is_leaf(heap)
    end
  end

  describe "is_next_leaf_in_left_subtree/1" do
    test "returns true parent index is divisible by 2" do
      # parent index is floor(5/2) = 2 => next leaf is to the left
      assert Guards.is_next_leaf_in_left_subtree(5)
    end

    test "returns false when size is not divisible by 2" do
      # parent index is floor(10/2) = 5 => next leaf is to the right
      refute Guards.is_next_leaf_in_left_subtree(10)
    end
  end

  describe "is_next_leaf_in_right_subtree/1" do
    test "returns true when parent index is not divisible by 2" do
      # parent index is floor(10/2) = 5 => next leaf is to the right
      assert Guards.is_next_leaf_in_right_subtree(10)
    end

    test "returns false when size is divisible by 2" do
      # parent index is floor(5/2) = 4 => next leaf is to the left
      refute Guards.is_next_leaf_in_right_subtree(5)
    end
  end
end
