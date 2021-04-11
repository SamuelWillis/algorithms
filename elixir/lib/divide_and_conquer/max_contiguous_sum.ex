defmodule ElixirImpl.DivideAndConquer.MaxContiguousSum do
  @moduledoc """
  Find the maximum contiguous sum in a provided list
  """

  alias ElixirImpl.ListHelpers

  @doc """
  Find the maximum contiguous sum in the provided list.
  """
  @spec find(list()) :: integer()
  def find([]), do: 0
  def find([el]), do: el

  def find(list) do
    middle = list |> length() |> div(2)

    {left, right} = ListHelpers.split(list, middle)

    left_sum = find(left)
    right_sum = find(right)
    cross_sum = find_cross_sum(left, right)

    cond do
      left_sum <= right_sum and cross_sum <= right_sum ->
        right_sum

      right_sum <= left_sum and cross_sum <= left_sum ->
        left_sum

      true ->
        cross_sum
    end
  end

  defp find_cross_sum(left, right) do
    left_sum = left |> ListHelpers.reverse() |> find_sum()
    right_sum = find_sum(right)

    left_sum + right_sum
  end

  defp find_sum(list, sum \\ nil)
  defp find_sum([head | tail], nil), do: find_sum(tail, head)
  defp find_sum([head | tail], sum) when sum <= sum + head, do: find_sum(tail, sum + head)
  defp find_sum(_list, sum), do: sum
end
