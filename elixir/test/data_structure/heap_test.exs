defmodule ElixrImpl.DataStructure.HeapTest do
  use ExUnit.Case, async: true

  alias ElixirImpl.DataStructure.Heap

  doctest Heap

  describe "new/0" do
    test "returns empty Heap" do
      assert %Heap{} == Heap.new()
    end
  end

  describe "from/1" do
    test "empty list" do
      assert %Heap{} == Heap.from([])
    end

    test "single element list" do
      assert %Heap{} = Heap.from([1])
    end

    test "list" do
      assert %Heap{} = Heap.from(1..10)
    end
  end

  describe "push/2" do
    test "pushes single element correctly" do
      assert %Heap{value: 10, height: 1, size: 1} == Heap.push(%Heap{}, 10)
    end

    test "pushes to left leaf first" do
      heap = Heap.from([1, 2])

      assert %Heap{
               value: 2,
               height: 2,
               size: 2,
               left: %Heap{value: 1, height: 1, size: 1}
             } == heap
    end

    test "pushes to right leaf when left is full" do
      heap = Heap.from(1..3)

      assert %Heap{
               value: 3,
               height: 2,
               size: 3,
               left: %Heap{value: 1, height: 1, size: 1},
               right: %Heap{value: 2, height: 1, size: 1}
             } == heap
    end
  end

  describe "pop/1" do
    test "returns error tuple when heap is empty" do
      assert {:error, "Heap is empty"} == Heap.pop(%Heap{})
    end

    test "returns ok tuple with value and heap" do
      heap = %Heap{value: 10, size: 1}
      assert {:ok, 10, %Heap{}} == Heap.pop(heap)
    end

    test "pop removes element from top of heap until empty" do
      heap = Heap.from(1..10)

      assert {:ok, 10, heap} = Heap.pop(heap)
      assert {:ok, 9, heap} = Heap.pop(heap)
      assert {:ok, 8, heap} = Heap.pop(heap)
      assert {:ok, 7, heap} = Heap.pop(heap)
      assert {:ok, 6, heap} = Heap.pop(heap)
      assert {:ok, 5, heap} = Heap.pop(heap)
      assert {:ok, 4, heap} = Heap.pop(heap)
      assert {:ok, 3, heap} = Heap.pop(heap)
      assert {:ok, 2, heap} = Heap.pop(heap)
      assert {:ok, 1, heap} = Heap.pop(heap)
      assert {:error, "Heap is empty"} = Heap.pop(heap)
    end
  end
end
