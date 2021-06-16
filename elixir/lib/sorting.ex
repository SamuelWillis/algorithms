defmodule ElixirImpl.Sorting do
  alias ElixirImpl.Sorting.InsertionSort
  alias ElixirImpl.Sorting.MergeSort

  @doc """
  Use insertion sort to sort the provided list
  """
  defdelegate insertion_sort(list), to: InsertionSort, as: :sort

  @doc """
  Use merge sort to sort the provided list
  """
  defdelegate merge_sort(list), to: MergeSort, as: :sort
end
