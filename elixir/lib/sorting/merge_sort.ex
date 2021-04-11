defmodule ElixirImpl.Sorting.MergeSort do
  @moduledoc """
  Merge sort implementation

  There is a much simpler version using built in functions.
  This implementation avoids using those.
  """

  alias ElixirImpl.ListHelpers

  @doc """
  Sort the provided list
  """
  @spec sort(list()) :: list()
  def sort([]), do: []
  def sort([_element] = list), do: list

  def sort(list) when is_list(list) do
    middle = div(length(list), 2)

    {left, right} = ListHelpers.split(list, middle)
    left = sort(left)
    right = sort(right)

    merge(left, right)
  end

  defp merge(left, right), do: do_merge([], left, right)

  defp do_merge(merged, [lh | lt], [rh | _rt] = r) when lh <= rh,
    do: do_merge([lh | merged], lt, r)

  defp do_merge(merged, [lh | _lt] = l, [rh | rt]) when rh < lh,
    do: do_merge([rh | merged], l, rt)

  defp do_merge(merged, [], [rh | rt]), do: do_merge([rh | merged], [], rt)
  defp do_merge(merged, [lh | lt], []), do: do_merge([lh | merged], lt, [])

  defp do_merge(merged, [], []), do: ListHelpers.reverse(merged)
end
