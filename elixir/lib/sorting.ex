defmodule ElixirImpl.Sorting do
  @moduledoc """
  Sorting algorithm implementations
  """

  alias ElixirImpl.Sorting.HeapSort
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

  @doc """
  Use heap sort to sort the provided list
  """
  defdelegate heap_sort(list), to: HeapSort, as: :sort
end
