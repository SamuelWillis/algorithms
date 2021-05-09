defmodule ElixirImpl.DataStructure.Heap.Helpers do
  import ElixirImpl.DataStructure.Heap.Guards,
    only: [
      is_heap: 1,
      is_leaf: 1
    ]

  alias ElixirImpl.DataStructure.Heap

  @doc false
  @spec bubble_up(heap :: Heap.t()) :: Heap.t()
  def bubble_up(%Heap{left: left} = heap)
      when is_heap(left) and heap.value < left.value,
      do: %Heap{heap | value: left.value, left: %Heap{left | value: heap.value}}

  def bubble_up(%Heap{right: right} = heap)
      when is_heap(right) and heap.value < right.value,
      do: %Heap{heap | value: right.value, right: %Heap{right | value: heap.value}}

  def bubble_up(%Heap{} = heap), do: heap

  @doc false
  @spec bubble_root_down(heap :: Heap.t()) :: Heap.t()
  def bubble_root_down(heap) when is_leaf(heap), do: heap
  def bubble_root_down(heap), do: bubble_down(heap)

  @doc false
  @spec bubble_down(heap :: Heap.t()) :: Heap.t()
  def bubble_down(%Heap{left: left, right: right} = heap)
      when is_heap(right) and heap.value < right.value and left.value < right.value,
      do: %Heap{
        heap
        | value: right.value,
          left: left,
          right: bubble_down(%Heap{right | value: heap.value})
      }

  def bubble_down(%Heap{left: left, right: right} = heap)
      when is_heap(left) and heap.value < heap.left.value,
      do: %Heap{
        heap
        | value: left.value,
          left: bubble_down(%Heap{left | value: heap.value}),
          right: right
      }

  def bubble_down(heap), do: heap

  @doc false
  @spec merge(left :: Heap.t(), right :: Heap.t()) :: Heap.t()
  def merge(left, right) when is_leaf(left) and is_nil(right),
    do: left

  def merge(left, right) when is_leaf(left) and is_leaf(right),
    do: %Heap{
      value: right.value,
      size: 2,
      height: 2,
      left: left
    }

  def merge(left, right) do
    cond do
      # If the left is not a complete binary tree, the last inserted element is
      # in the left hand tree
      left.size < :math.pow(2, left.height) - 1 ->
        float_left(left, merge(left.left, left.right), right)

      # If the left is complete and right is not complete, the last inserted element
      # is in the right hand tree
      right.size < :math.pow(2, right.height) - 1 ->
        float_right(right, left, merge(right.left, right.right))

      # If we have 2 complete trees and the left has a higher height, then go to
      # the left tree for last inserted element as Heap is complete binary tree,
      # so we insert elements into left hand tree last
      right.height < left.height ->
        float_left(left, merge(left.left, left.right), right)

      # O/W we have 2 complete trees and the left height is not larger than
      # the right height. So we go into the right hand tree for the last
      # inserted element.
      true ->
        float_right(right, left, merge(right.left, right.right))
    end
  end

  @doc false
  @spec float_left(original_left :: Heap.t(), new_left :: Heap.t(), right :: Heap.t()) :: Heap.t()
  def float_left(original_left, new_left, right),
    do: %Heap{
      value: new_left.value,
      size: new_left.size + right.size + 1,
      height: max(new_left.height, right.height) + 1,
      left: %Heap{new_left | value: original_left.value},
      right: right
    }

  @doc false
  @spec float_right(original_right_heap :: Heap.t(), left :: Heap.t(), new_right :: Heap.t()) ::
          Heap.t()
  def float_right(original_right_heap, left, new_right),
    do: %Heap{
      value: new_right.value,
      size: new_right.size + left.size + 1,
      height: max(original_right_heap.height, left.height) + 1,
      left: left,
      right: %Heap{new_right | value: original_right_heap.value}
    }
end
