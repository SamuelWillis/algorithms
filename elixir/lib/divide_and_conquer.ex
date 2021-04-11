defmodule ElixirImpl.DivideAndConquer do
  @moduledoc """
  General divide and conquer algorithms.
  """

  alias ElixirImpl.DivideAndConquer.MaxContiguousSum

  @doc """
  Find the max contiguous sum in the provided list

  ## Examples

    iex> DivideAndConquer.max_contiguous_sum([])
    0

    iex> DivideAndConquer.max_contiguous_sum([10])
    10

    iex> DivideAndConquer.max_contiguous_sum([1, 2, 3])
    6

    iex> DivideAndConquer.max_contiguous_sum([-1, -10])
    -1
  """
  @spec max_contiguous_sum(list()) :: integer()
  defdelegate max_contiguous_sum(list), to: MaxContiguousSum, as: :find
end
