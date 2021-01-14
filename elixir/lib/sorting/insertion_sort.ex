defmodule ElixirImpl.Sorting.InsertionSort do
  @moduledoc """
  Insertion sort implementation
  """

  @doc """
  Sort the provided list
  """
  @spec sort(list()) :: list()
  def sort(list) when is_list(list) do
    do_sort([], list)
  end

  defp do_sort(_sorted = [], _unsorted = [head | tail]), do: do_sort([head], tail)
  defp do_sort(sorted, _unsorted = [head | tail]), do: head |> insert(sorted) |> do_sort(tail)
  defp do_sort(sorted, _unsorted), do: sorted

  # if sorted is empty, return array of just element
  defp insert(element, _sorted = []), do: [element]
  # if element is less than the first element of the first list, insert at front
  defp insert(element, [min | _rest] = sorted) when element <= min, do: [element | sorted]
  # Otherwise try insert element into remainder of sorted list
  defp insert(element, [min | rest]), do: [min | insert(element, rest)]
end
