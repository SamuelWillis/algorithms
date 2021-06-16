defmodule ElixirImpl.Sorting.HeapSort do
  @moduledoc """
  Heap sort implementation
  """

  alias ElixirImpl.DataStructure.Heap

  @doc """
  Sort the list using a heap.

  Works by:
  1. Placing list onto a Max heap
  2. Popping elements off the heap and prepending them to ordered list until
     heap is empty

  ## Examples

    iex> HeapSort.sort([])
    []

    iex> HeapSort.sort([1])
    [1]

    iex> HeapSort.sort([1, 0])
    [0, 1]

    iex> HeapSort.sort([1, -1, 0])
    [-1, 0, 1]
  """
  @spec sort(list()) :: list()
  def sort([]), do: []
  def sort([el]), do: [el]

  def sort(list), do: list |> Heap.from() |> pop_elements()

  defp pop_elements(heap, ordered_list \\ []) do
    case Heap.empty?(heap) do
      true ->
        ordered_list

      _ ->
        {:ok, el, heap} = Heap.pop(heap)
        pop_elements(heap, [el | ordered_list])
    end
  end
end
