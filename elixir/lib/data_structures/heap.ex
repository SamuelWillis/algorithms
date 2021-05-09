defmodule ElixirImpl.DataStructure.Heap do
  @moduledoc """
  A functional implementation of the heap data structure.

  This was written based on readings from:
    * [Paul Picazo's Peaps Paper](https://www.cpp.edu/~ftang/courses/CS241/notes/Building_Heaps_With_Pointers.pdf)
    * Vladimir Kostyukov's [Scala Heap Post](https://kostyukov.net/posts/designing-a-pfds/), [paper](http://arxiv.org/pdf/1312.4666v1.pdf) and [source code](https://github.com/vkostyukov/scalacaster/blob/master/src/heap/StandardHeap.scala)

  Currently only supports max heaps.
  """

  import ElixirImpl.DataStructure.Heap.Guards,
    only: [
      is_empty: 1,
      is_leaf: 1,
      is_next_leaf_in_left_subtree: 1,
      is_next_leaf_in_right_subtree: 1
    ]

  alias ElixirImpl.DataStructure.Heap.Helpers

  defstruct(height: 0, left: nil, right: nil, size: 0, value: nil)

  @type t :: %__MODULE__{
          height: integer(),
          left: t() | nil,
          right: t() | nil,
          size: integer(),
          value: integer() | nil
        }

  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Create a heap from the provided list.
  """
  @spec from([integer()] | Range.t()) :: t()
  def from([]), do: new()
  def from(list) when is_list(list), do: do_from(new(), list)
  def from(%Range{} = range), do: range |> Enum.to_list() |> from()

  defp do_from(heap, [head | tail]), do: heap |> push(head) |> do_from(tail)
  defp do_from(heap, []), do: heap

  @doc """
  push the new value into the heap.

  - O(logn)

  This does two traversals:
    1. Down the heap to find the next available leaf
    2. Back up the heap, ensuring max heap property is maintained with the new
       value pushed
  """
  @spec push(t(), integer()) :: t()
  def push(%__MODULE__{} = heap, value) when is_empty(heap),
    do: %__MODULE__{value: value, height: 1, size: 1}

  def push(%__MODULE__{height: height, size: size} = heap, value) when is_leaf(heap),
    do:
      Helpers.bubble_up(%__MODULE__{
        heap
        | height: height + 1,
          size: size + 1,
          left: push(%__MODULE__{}, value)
      })

  def push(%__MODULE__{size: size, left: left, right: right} = heap, value) when is_nil(right),
    do:
      Helpers.bubble_up(%__MODULE__{
        heap
        | size: size + 1,
          left: left,
          right: push(%__MODULE__{}, value)
      })

  def push(%__MODULE__{left: left, right: right, size: size} = heap, value)
      when is_next_leaf_in_left_subtree(size + 1) do
    new_left = push(left, value)

    Helpers.bubble_up(%__MODULE__{
      heap
      | height: max(new_left.height, right.height) + 1,
        size: size + 1,
        left: push(left, value),
        right: right
    })
  end

  def push(%__MODULE__{left: left, right: right, size: size} = heap, value)
      when is_next_leaf_in_right_subtree(size + 1) do
    new_right = push(right, value)

    Helpers.bubble_up(%__MODULE__{
      heap
      | height: max(left.height, new_right.height) + 1,
        size: size + 1,
        left: left,
        right: new_right
    })
  end

  @doc """
  Pops the top value off the heap


  Performs 3 traversals
    - First finds the last inserted leaf
    - Second bubbles the last inserted leaf up to the root
    - Third bubbles the new root "down" to a proper position
  """
  @spec pop(t()) :: {:ok, integer(), t()} | {:error, binary()}
  def pop(%__MODULE__{} = heap) when is_empty(heap), do: {:error, "Heap is empty"}
  def pop(%__MODULE__{} = heap) when is_leaf(heap), do: {:ok, heap.value, new()}

  def pop(%__MODULE__{value: value, left: left, right: right}) do
    {:ok, value, Helpers.bubble_root_down(Helpers.merge(left, right))}
  end

  @doc """
  Checks if the heap is empty.

  ## Examples
    iex> Heap.empty?(Heap.new())
    true

    iex> Heap.new()
    ...>   |> Heap.push(1)
    ...>   |> Heap.empty?()
    false
  """
  def empty?(%__MODULE__{} = heap) when is_empty(heap), do: true
  def empty?(%__MODULE__{} = _heap), do: false
end
