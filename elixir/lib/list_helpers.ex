defmodule ElixirImpl.ListHelpers do
  @moduledoc """
  List helpers.
  There are definitely language functions for this but implementing these
  functions have helped me better my elixir skills.
  """

  @doc """
  Split a list into two parts leaving count elements in the first part.

  ## Examples

    iex> ListHelpers.split([1, 2, 3, 4], 2)
    {[1, 2] ,[3, 4]}

    iex> ListHelpers.split([1, 2, 3], 10)
    {[1, 2, 3], []}

    iex> ListHelpers.split([1, 2, 3], 0)
    {[], [1, 2, 3]}

    iex> ListHelpers.split([], 1)
    {[], []}
  """
  @spec split(list(), integer) :: {list(), list()}
  def split(list, count), do: do_split({[], list}, count)

  defp do_split({left, [head | tail]}, count) when 0 < count,
    do: do_split({[head | left], tail}, count - 1)

  defp do_split({left, right}, 0), do: {reverse(left), right}

  defp do_split({left, []}, _count), do: {reverse(left), []}

  @doc """
  Reverse a list

  ## Examples
    iex> ListHelpers.reverse([])
    []

    iex> ListHelpers.reverse([1, 2, 3])
    [3, 2, 1]
  """
  @spec reverse(list()) :: list()
  def reverse(list), do: do_reverse([], list)

  defp do_reverse([], [head | tail]), do: do_reverse([head], tail)
  defp do_reverse(list, [head | tail]), do: do_reverse([head | list], tail)
  defp do_reverse(list, []), do: list
end
