defmodule ElixirImpl.Sorting do
  alias ElixirImpl.Sorting.InsertionSort

  @doc """
  Use insertion sort to sort the provided list
  """
  defdelegate insertion_sort(list), to: InsertionSort, as: :sort
end
