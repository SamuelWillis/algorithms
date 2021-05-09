defmodule ElixirImpl.DataStructure.Heap.Guards do
  @moduledoc """
  Function guards for the heap data structure

  Used to reduce repetition and make the Heap code easier to follow.
  """

  alias ElixirImpl.DataStructure.Heap

  @doc """
  Is the heap emtpy?
  """
  defguard is_empty(heap) when heap.size == 0

  @doc """
  Is the passed argument a heap?
  """
  defguard is_heap(heap) when is_struct(heap, Heap)

  @doc """
  Is the passed heap a leaf node?

  A heap is considered a leaf if it has no children.
  """
  defguard is_leaf(heap) when is_nil(heap.left) and is_nil(heap.right)

  @doc """
  Determine if the next available leaf is in the left subtree of tree of size `size`.

  To determine if the leaf for a new node is in the left subtree we act as if we are
  trying to find its parent index in an array definition.

  So given the index of the pushed value in the tree, `size`, the new node will be
  in the left tree if its parent index is divisible by 2.

  This comes from the array definitions `left(i): 2*i` and `parent(i): floor(i/2)`.
  """
  defguard is_next_leaf_in_left_subtree(size) when size |> div(2) |> rem(2) == 0

  @doc """
  Determine if the next available leaf is in the right subtree of tree of size `size`.

  To determine if the leaf for a new node is in the right subtree we act as if we are
  trying to find its parent index in an array definition.

  So given the index of the pushed value in the tree, `size`, the new node will be
  in the right tree if its parent index is not divisible by 2.

  This comes from the array definitions `right(i): 2*i + 1` and `parent(i): floor(i/2)`.
  """
  defguard is_next_leaf_in_right_subtree(size) when size |> div(2) |> rem(2) == 1
end
