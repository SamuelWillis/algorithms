defmodule ElixrImpl.DataStructure.Heap.HelpersTest do
  use ExUnit.Case, async: true

  alias ElixirImpl.DataStructure.Heap
  alias ElixirImpl.DataStructure.Heap.Helpers

  describe "merge/2" do
    test "merges left child is most recent insert correctly" do
      left = Heap.new() |> Heap.push(1)
      right = nil

      assert left == Helpers.merge(left, right)
    end

    test "merges right child is most recent insert correctly" do
      left = Heap.new() |> Heap.push(1)
      right = Heap.new() |> Heap.push(2)

      assert %Heap{
               value: right.value,
               height: 2,
               size: 2,
               left: left,
               right: nil
             } == Helpers.merge(left, right)
    end

    test "merges incomplete left heap correctly" do
      left = Heap.new() |> Heap.push(3) |> Heap.push(1)
      right = Heap.new() |> Heap.push(2)

      assert %Heap{
               value: left.left.value,
               height: 2,
               size: 3,
               left: %Heap{
                 value: left.value,
                 size: 1,
                 height: 1
               },
               right: right
             } == Helpers.merge(left, right)
    end

    test "merges incomplete right heap correctly" do
      left = Heap.new() |> Heap.push(5) |> Heap.push(3) |> Heap.push(2)
      right = Heap.new() |> Heap.push(4) |> Heap.push(1)

      assert %Heap{
               value: right.left.value,
               height: 3,
               size: 5,
               left: left,
               right: %Heap{
                 value: right.value,
                 height: 1,
                 size: 1
               }
             } == Helpers.merge(left, right)
    end

    test "merges taller left heap correctly" do
      left = Heap.new() |> Heap.push(7) |> Heap.push(5) |> Heap.push(4) |> Heap.push(1)
      right = Heap.new() |> Heap.push(6) |> Heap.push(3) |> Heap.push(2)

      assert %Heap{
               # 1
               value: left.left.left.value,
               height: 3,
               size: 7,
               left: %Heap{
                 value: left.value,
                 height: 2,
                 size: 3,
                 left: Heap.new() |> Heap.push(5),
                 right: Heap.new() |> Heap.push(4)
               },
               right: right
             } == Helpers.merge(left, right)
    end

    test "merges matching height left and right heaps correctly" do
      left = Heap.new() |> Heap.push(6) |> Heap.push(4) |> Heap.push(3)
      right = Heap.new() |> Heap.push(5) |> Heap.push(2) |> Heap.push(1)

      assert %Heap{
               value: right.right.value,
               height: 3,
               size: 6,
               left: left,
               right: %Heap{
                 value: right.value,
                 height: 2,
                 size: 2,
                 left: Heap.new() |> Heap.push(2)
               }
             } == Helpers.merge(left, right)
    end
  end

  describe "bubble_up/1" do
    test "builds heap correctly when left child value is larger than parent" do
      left = %Heap{
        value: 10,
        size: 1,
        left: %Heap{value: 0, size: 1},
        right: %Heap{value: 0, size: 1}
      }

      right = %Heap{value: 0, size: 1}
      parent = %Heap{value: 1, size: 3, left: left, right: right}

      assert %Heap{
               value: left.value,
               size: parent.size,
               left: %Heap{
                 value: parent.value,
                 size: left.size,
                 left: left.left,
                 right: left.right
               },
               right: right
             } == Helpers.bubble_up(parent)
    end

    test "builds heap correctly when right child value is larger than parent" do
      right = %Heap{
        value: 10,
        size: 1,
        left: %Heap{value: 0, size: 1},
        right: %Heap{value: 0, size: 1}
      }

      left = %Heap{value: 0, size: 1}
      parent = %Heap{value: 1, size: 3, left: left, right: right}

      assert %Heap{
               value: right.value,
               size: parent.size,
               left: left,
               right: %Heap{
                 value: parent.value,
                 size: right.size,
                 left: right.left,
                 right: right.right
               }
             } == Helpers.bubble_up(parent)
    end

    test "builds heap correctly when heap property maintained" do
      left = %Heap{value: 0, size: 1}
      right = %Heap{value: 0, size: 1}
      parent = %Heap{value: 10, size: 3, left: left, right: right}

      assert %Heap{
               value: parent.value,
               size: parent.size,
               left: left,
               right: right
             } == Helpers.bubble_up(parent)
    end
  end
end
